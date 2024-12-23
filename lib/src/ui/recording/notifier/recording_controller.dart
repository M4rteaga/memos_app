import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:memo_app/src/ui/recording/models/recording_model.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/recording_state_enum.dart';

part 'recording_controller.g.dart';

@riverpod
class RecordingNotifier extends _$RecordingNotifier {
  late AudioRecorder _record;
  late PermissionStatus _microphonePermissionStatus;

  @override
  FutureOr<RecordingModel> build() async {
    _microphonePermissionStatus = await Permission.microphone.request();

    _record = AudioRecorder();
    if (_microphonePermissionStatus.isGranted) {

      await _initializeAudioSession();
    }
    return RecordingModel(recordingState: RecordingState.none);
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
    // final amplitudStream  = _record.onAmplitudeChanged(Duration(milliseconds: 1));
    // amplitudStream.listen((amplitud) => print('esta es la amplitud current ${amplitud.current} y max ${amplitud.max}'));

    state = AsyncValue.data(RecordingModel(recordingState: RecordingState.recording, recording: stream));
  }

  Future<void> pauseRecording() async {
    await _record.pause();

state = AsyncValue.data(RecordingModel(recordingState: RecordingState.paused, recording: state.value?.recording));
  }

  Future<void> resumeRecording() async {
    if(await _record.isPaused()){
      await _record.resume();
    }

state = AsyncValue.data(RecordingModel(recordingState: RecordingState.recording, recording: state.value?.recording));
  }

  Future<void> stopRecording() async {
    final nose = await _record.stop();
    
    await _record.dispose();

    print("este es el nose $nose");
state = AsyncValue.data(RecordingModel(recordingState: RecordingState.none, recording: null));
  }
}
