import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

part 'recording_controller.g.dart';

///Recording screen has 4 basic states
/// Non in which the screen just shows the initial message
/// Recording in which the screen start the recording animation and so
/// Pause, recording stops but the user can continue recording
/// end, the user ends the recording
enum RecordingState {
  non,
  recording,
  paused,
  finish,
}

@riverpod
class RecordingNotifier extends _$RecordingNotifier {
  late AudioRecorder _record;
  late PermissionStatus _microphonePermissionStatus;

  @override
  FutureOr<RecordingState> build() async {
    _microphonePermissionStatus = await Permission.microphone.request();

    _record = AudioRecorder();
    if (_microphonePermissionStatus.isGranted) {

      await _initializeAudioSession();
    }
    return RecordingState.non;
  }

  Future<void> _initializeAudioSession() async {
    final session = await AudioSession.instance;
    ///Necessary config for recording on iOS devices
    await session.configure(
      AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.allowBluetooth |
                AVAudioSessionCategoryOptions.defaultToSpeaker,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy:
            AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          flags: AndroidAudioFlags.none,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ),
    );
  }

  Future<void> startRecording() async {
    final stream = await _record.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
      ),
    );

    stream.listen(
      (event) => print('evento data $event'),
      onError: (e) => print('este es el error $e'),
    );

    state = AsyncValue.data(RecordingState.recording);
  }

  Future<void> pauseRecording() async {
    await _record.cancel();
    state = AsyncValue.data(RecordingState.recording);
  }

  Future<void> stopRecording() async {
    state = AsyncValue.data(RecordingState.recording);
  }
}
