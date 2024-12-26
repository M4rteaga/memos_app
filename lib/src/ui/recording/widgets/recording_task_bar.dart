import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/recording_state_enum.dart';
import '../notifier/recording_controller.dart';
import 'recording_button.dart';

class RecordingTaskBar extends ConsumerWidget {
  const RecordingTaskBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(recordingNotifierProvider);
    return switch (asyncState) {
      AsyncData(:final value) => switch (value) {
          RecordingState.none || RecordingState.end => RecordingButtons.record(
              onRecordPressed: () =>
                  ref.read(recordingNotifierProvider.notifier).startRecording(),
            ),
          RecordingState.recording => RecordingButtons.recording(
              onPausePressed: () =>
                  ref.read(recordingNotifierProvider.notifier).pauseRecording(),
              onDeletePressed: () => {}, //TODO: add method
              onStopPressed: () =>
                  ref.read(recordingNotifierProvider.notifier).endRecording(),
            ),
          RecordingState.paused => RecordingButtons.paused(
              onResumePressed: () => ref
                  .read(recordingNotifierProvider.notifier)
                  .resumeRecording(),
              onDeletePressed: () => ref
                  .read(recordingNotifierProvider.notifier)
                  .endRecording(), //TODO: add method
              onStopPressed: () =>
                  ref.read(recordingNotifierProvider.notifier).endRecording(),
            ),
        },
      _ => SizedBox(),
    };
  }
}
