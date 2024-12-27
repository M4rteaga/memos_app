import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../models/exceptions.dart';
import '../models/memo_object.dart';
import 'gcs_api.dart';

class MemosApi {
  static Future<Either<List<MemoObject>, CustomMemosException>> getMemos() async {
    return await GcsApi.listBucketContent();
  }

  static Future<Either<Stream<List<int>>, CustomMemosException>> getMemosData(
      String fileName) async {
    return await GcsApi.getMedia(fileName);
  }

  static Future<Either<Map<String, dynamic>, CustomMemosException>> saveMemo(
    Uint8List content, {
    required String customName,
  }) async {
    return await GcsApi.saveToBucket(content, fileName: customName);
  }
}
