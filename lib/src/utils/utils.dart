import 'dart:typed_data';

class Utils {
  static Uint8List flattenUint8List(List<Uint8List> dataList) {
      int totalLength = dataList.fold(0, (sum, pcm) => sum + pcm.length);
      Uint8List flattenDataBuffer = Uint8List(totalLength);
      int offset = 0;

      for (var chunk in dataList) {
        flattenDataBuffer.setRange(offset, offset + chunk.length, chunk);
        offset += chunk.length;
      }
      
      return flattenDataBuffer;
  }
}
