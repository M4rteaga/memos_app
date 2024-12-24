import 'package:flutter/foundation.dart';

import 'gcs_api.dart';

class MemoApi {
  Future<void> getMemos() async {}

  static Future<void> saveMemo(
    Uint8List content, {
    required String customName,
  }) async {
    await GcsApi.saveToBucket(content, fileName: customName);
  }
}
