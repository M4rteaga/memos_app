import 'dart:typed_data';

class WAVFileHelper {
  ///this method adds the corresponding headers to transform pcm info to wav format
  ///
  static Future<Uint8List> pcmToWav({
    required List<Uint8List> pcmDataList,
    int sampleRate = 44100,
    int bitDepth = 16,
    int channels = 1,
  }) async {
    // Combine the List<Uint8List> into a single Uint8List
    int totalLength = pcmDataList.fold(0, (sum, pcm) => sum + pcm.length);
    Uint8List pcmData = Uint8List(totalLength);
    int offset = 0;

    for (var chunk in pcmDataList) {
      pcmData.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }

    // Calculate sizes
    final int byteRate = (sampleRate * channels * bitDepth) ~/ 8;
    final int blockAlign = (channels * bitDepth) ~/ 8;
    final int dataSize = pcmData.length;
    final int chunkSize = 36 + dataSize;

    // Create WAV header
    final wavHeader = Uint8List(44);
    final data = ByteData.sublistView(wavHeader);

    // RIFF chunk descriptor
    data.setUint32(0, 0x52494646, Endian.big); // "RIFF"
    data.setUint32(4, chunkSize, Endian.little); // File size - 8 bytes
    data.setUint32(8, 0x57415645, Endian.big); // "WAVE"

    // fmt sub-chunk
    data.setUint32(12, 0x666d7420, Endian.big); // "fmt "
    data.setUint32(16, 16, Endian.little); // Subchunk1 size (16 for PCM)
    data.setUint16(20, 1, Endian.little); // Audio format (1 = PCM)
    data.setUint16(22, channels, Endian.little); // Number of channels
    data.setUint32(24, sampleRate, Endian.little); // Sample rate
    data.setUint32(28, byteRate, Endian.little); // Byte rate
    data.setUint16(32, blockAlign, Endian.little); // Block align
    data.setUint16(34, bitDepth, Endian.little); // Bits per sample

    // data sub-chunk
    data.setUint32(36, 0x64617461, Endian.big); // "data"
    data.setUint32(40, dataSize, Endian.little); // Subchunk2 size (data size)

    // Combine header and PCM data
    final wavData = Uint8List(wavHeader.length + pcmData.length)
      ..setRange(0, wavHeader.length, wavHeader)
      ..setRange(wavHeader.length, wavHeader.length + pcmData.length, pcmData);

    return wavData;
  }
}
