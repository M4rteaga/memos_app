import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:memo_app/src/utils/wav_file_heper.dart';
import 'package:memo_app/src/repository/memos_api.dart';
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
  FutureOr<RecordingState> build() async {
    final microphonePermissionStatus = await Permission.microphone.request();

    _record = AudioRecorder();
    if (microphonePermissionStatus.isGranted) {
      await _initializeAudioSession();
    }

    ref.onDispose(() async {
      await _record.dispose();
    });
    return RecordingState.none;
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

    state = AsyncValue.data(RecordingState.recording);
  }

  Future<void> pauseRecording() async {
    await _record.pause();

    state = AsyncValue.data(RecordingState.paused);
  }

  Future<void> resumeRecording() async {
    if (await _record.isPaused()) {
      await _record.resume();
    }

    state = AsyncValue.data(RecordingState.recording);
  }

  Future<void> endRecording() async {
    await _record.stop();

    state = AsyncValue.data(RecordingState.end);
  }

  Future<void> saveRecording(String customName) async {
    state = AsyncValue.data(RecordingState.uploading);
    if (!(await _record.isRecording()) && _dataBuffer.isNotEmpty) {
      final wavData = await WAVFileHelper.pcmToWav(
        pcmDataList: _dataBuffer,
        channels: _recordingConfig.numChannels,
        sampleRate: _recordingConfig.sampleRate,
      );
      await MemosApi.saveMemo(wavData, customName: customName);
    }

    state = AsyncValue.data(RecordingState.susccesfulyUpload);
  }

  Future<void> discardRecording() async {
    await _record.cancel();

    _dataBuffer.clear();

    state = AsyncValue.data(RecordingState.none);
  }
}
