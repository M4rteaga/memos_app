import 'package:flutter/foundation.dart';

import '../models/memo_object.dart';
import 'gcs_api.dart';

class MemosApi {
  static Future<List<MemoObject>> getMemos() async {
    return await GcsApi.listBucketContent();
  }

  static Future<Stream<List<int>>> getMemosData(String fileName) async {
    return await GcsApi.getMedia(fileName);
  }

  static Future<void> saveMemo(
    Uint8List content, {
    required String customName,
  }) async {
    await GcsApi.saveToBucket(content, fileName: customName);
  }
}
