import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:memo_app/src/helpers/wav_file_heper.dart';
import 'package:memo_app/src/repository/memo_api.dart';
import 'package:memo_app/src/ui/recording/models/recording_model.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/recording_state_enum.dart';

part 'recording_controller.g.dart';

@riverpod
class RecordingNotifier extends _$RecordingNotifier {
  late AudioRecorder _record;
  final List<Uint8List> _dataBuffer = [];
  final _recordingConfig = RecordConfig(
    encoder: AudioEncoder.pcm16bits,
  );

  @override
  FutureOr<RecordingModel> build() async {
    final microphonePermissionStatus = await Permission.microphone.request();

    _record = AudioRecorder();
    if (microphonePermissionStatus.isGranted) {
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
    final stream = await _record.startStream(_recordingConfig);

    stream.listen((data) => _dataBuffer.add(data));

    state = AsyncValue.data(RecordingModel(
        recordingState: RecordingState.recording, recording: stream));
  }

  Future<void> pauseRecording() async {
    await _record.pause();

    state = AsyncValue.data(
      RecordingModel(
        recordingState: RecordingState.paused,
        recording: state.value?.recording,
      ),
    );
  }

  Future<void> resumeRecording() async {
    if (await _record.isPaused()) {
      await _record.resume();
    }

    state = AsyncValue.data(
      RecordingModel(
        recordingState: RecordingState.recording,
        recording: state.value?.recording,
      ),
    );
  }

  Future<void> endRecording() async {
    await _record.stop();

    state = AsyncValue.data(RecordingModel(
        recordingState: RecordingState.end, recording: state.value?.recording));
  }

  Future<void> saveRecording(String customName) async {
    if (!(await _record.isRecording()) && _dataBuffer.isNotEmpty) {
      final wavData = await WAVFileHelper.pcmToWav(
        pcmDataList: _dataBuffer,
        channels: _recordingConfig.numChannels,
        sampleRate: _recordingConfig.sampleRate,
      );
      await MemoApi.saveMemo(wavData, customName: customName);
    }

    _dataBuffer.clear();

    state = AsyncValue.data(
        RecordingModel(recordingState: RecordingState.none, recording: null));
  }
}
