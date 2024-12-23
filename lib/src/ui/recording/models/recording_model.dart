import 'dart:typed_data';

import 'recording_state_enum.dart';

class RecordingModel {
  RecordingModel({
    required this.recordingState,
    this.recording,
  });

  Stream<Uint8List>? recording;
  RecordingState recordingState;
}
