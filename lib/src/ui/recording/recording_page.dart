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
                  RecordingState.non => RecordingButtons.record(
                      onRecordPressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .startRecording(),
                    ),
                  RecordingState.recording => RecordingButtons.recording(
                      onPausePressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .pauseRecording(),
                      onDeletePressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .stopRecording(),
                      onStopPressed: () => ref
                          .read(recordingNotifierProvider.notifier)
                          .stopRecording(),
                    ),
                  // RecordingState.paused => TextButton(
                  //     onPressed: () => {},
                  //     child: Icon(
                  //       Icons.play_arrow,
                  //       color: Colors.black12,
                  //       size: 46,
                  //     )),
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
