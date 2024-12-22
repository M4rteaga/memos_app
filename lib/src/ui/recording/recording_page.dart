import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/recording/widgets/recording_button.dart';

import 'controller/recording_controller.dart';

class RecordingPage extends ConsumerWidget {
  const RecordingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(recordingNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Record your idea'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Start recording'),
            switch (asyncState) {
              AsyncData state => switch (state.value) {
                  RecordingState.none => RecordingButtons.record(
                      onRecordPressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .startRecording(),
                    ),
                  RecordingState.recording => RecordingButtons.recording(
                      onPausePressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .pauseRecording(),
                      onDeletePressed: () => {}, //TODO: add method
                      onStopPressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .stopRecording(),
                    ),
                  RecordingState.paused => RecordingButtons.paused(
                      onResumePressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .resumeRecording(),
                      onDeletePressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .stopRecording(), //TODO: add method
                      onStopPressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .stopRecording(),
                    ),
                  _ => SizedBox(),
                },
              _ => SizedBox(),
            }
          ],
        ),
      ),
    );
  }
}
