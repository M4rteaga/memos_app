import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:memo_app/src/models/exceptions.dart';
import 'package:memo_app/src/models/memo_object.dart';

class GcsApi {
  static const _serviceAccountPath = 'assets/service_account.json';
  static const _bucketName = 'bucket-memo-app';

  static Future<Map<String, dynamic>> _loadCredentials() async {
    try {
      final nose = await rootBundle
          .loadStructuredData<dynamic>(_serviceAccountPath, (jsonStr) async {
        return json.decode(jsonStr);
      });
      return nose as Map<String, dynamic>;
    } catch (error) {
      debugPrint('error trying to read credentials $error');
      return {};
    }
  }

  static Future<Either<AutoRefreshingAuthClient, Exception>>
      _authenticate() async {
    try {
      final credentials =
          ServiceAccountCredentials.fromJson(await _loadCredentials());

      return Left(await clientViaServiceAccount(
          credentials, [StorageApi.devstorageReadWriteScope]));
    } catch (e) {
      debugPrint('Error authenticating $e');
      return Right(CustomMemosException.authenticationException());
    }
  }

  static Future<Either<Map<String, dynamic>, CustomMemosException>>
      saveToBucket(
    Uint8List content, {
    String? bucketName,
    String? fileName,
  }) async {
    try {
      final AutoRefreshingAuthClient? httpClient =
          (await _authenticate()).match(
        (l) => l,
        (r) => null,
      );

      if (httpClient == null) {
        throw Exception('Bad http client');
      }

      final storageApi = StorageApi(httpClient);

      Object bucketObject;

      if (fileName != null) {
        bucketObject = Object(name: 'memos/$fileName.wav');
      } else {
        bucketObject = Object(name: 'memos/memos_record${Random()}}.wav');
      }

      final resp = await storageApi.objects.insert(
        bucketObject,
        _bucketName,
        // uploadOptions: UploadOptions,
        uploadMedia: Media(
            Stream.fromIterable([content]), content.lengthInBytes,
            contentType: 'audio/wav'),
      );

      httpClient.close();

      if (resp.id != null && resp.id!.isNotEmpty) {
        return Left({"etag": resp.etag ?? ""});
      }

      return Right(CustomMemosException.uploadingException());
    } on Exception catch (e) {
      debugPrint('Uploading exceptin $e');
      return Right(CustomMemosException.uploadingException());
    }
  }

  static Future<Either<List<MemoObject>, CustomMemosException>>
      listBucketContent() async {
    try {
      final List<MemoObject> memoObjects = [];
      final AutoRefreshingAuthClient? httpClient =
          (await _authenticate()).match(
        (l) => l,
        (r) => null,
      );

      if (httpClient == null) {
        throw Exception('Bad http client');
      }

      final storageApi = StorageApi(httpClient);

      final resp =
          await storageApi.objects.list(_bucketName, matchGlob: 'memos/**.wav');

      httpClient.close();

      resp.items?.forEach((o) {
        if (o.etag != null) {
          memoObjects.add(
            MemoObject(
              id: o.etag ?? '',
              name: o.name ?? '',
              size: int.tryParse(o.size ?? '') ?? 0,
            ),
          );
        }
      });

      if (memoObjects.isNotEmpty) {
        return Left(memoObjects);
      }

      return Right(CustomMemosException.emptyRecordsException());
    } on Exception catch (e) {
      debugPrint("Retriving bucket objects exception $e");
      return Right(CustomMemosException.listBucketContentException());
    }
  }

  static Future<Either<Stream<List<int>>, CustomMemosException>> getMedia(
      String fileName) async {
    try {
      final AutoRefreshingAuthClient? httpClient =
          (await _authenticate()).match(
        (l) => l,
        (r) => null,
      );

      if (httpClient == null) {
        throw Exception('Bad http client');
      }

      final storageApi = StorageApi(httpClient);

      final media = await storageApi.objects.get(
        _bucketName,
        'memos/$fileName',
        downloadOptions: DownloadOptions.fullMedia,
      ) as Media;

      final stream = media.stream;

      return Left(stream);
    } on Exception catch (e) {
      debugPrint("media exception $e");
      return Right(CustomMemosException.mediaException());
    }
  }
}
