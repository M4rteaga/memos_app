import 'package:flutter/material.dart';
import 'package:memo_app/src/ui/recording/controller/recording_controller.dart';

class RecordingButtons extends StatelessWidget {
  const RecordingButtons({
    super.key,
    required this.recordingState,
    this.onRecordPressed,
    this.onPausePressed,
    this.onDeletePressed,
    this.onStopPressed,
    this.onResumePressed,
  });
  final RecordingState recordingState;
  final VoidCallback? onRecordPressed;
  final VoidCallback? onPausePressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onStopPressed;
  final VoidCallback? onResumePressed;

  factory RecordingButtons.record({
    required onRecordPressed,
  }) {
    return RecordingButtons(
        onRecordPressed: onRecordPressed, recordingState: RecordingState.none);
  }

  factory RecordingButtons.recording({
    required onPausePressed,
    required onDeletePressed,
    required onStopPressed,
  }) {
    return RecordingButtons(
        onPausePressed: onPausePressed,
        onDeletePressed: onDeletePressed,
        onStopPressed: onStopPressed,
        recordingState: RecordingState.recording);
  }

  factory RecordingButtons.paused({
    required onResumePressed,
    required onDeletePressed,
    required onStopPressed,
  }) {
    return RecordingButtons(
      onResumePressed: onResumePressed,
      onDeletePressed: onDeletePressed,
      onStopPressed: onStopPressed,
      recordingState: RecordingState.paused,
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (recordingState) {
      RecordingState.none => TextButton(
          onPressed: onRecordPressed,
          child: Icon(
            Icons.radio_button_checked_rounded,
            color: Colors.red,
            size: 46,
          )),
      RecordingState.recording => Row(
          children: [
            TextButton(
                onPressed: onDeletePressed,
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                  size: 46,
                )),
            TextButton(
                onPressed: onPausePressed,
                child: Icon(
                  Icons.pause_circle_outline_rounded,
                  color: Colors.black12,
                  size: 46,
                )),
            TextButton(
                onPressed: onStopPressed,
                child: Icon(
                  Icons.stop_circle_outlined,
                  color: Colors.green,
                  size: 46,
                )),
          ],
        ),
      RecordingState.paused => Row(
          children: [
            TextButton(
                onPressed: onDeletePressed,
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                  size: 46,
                )),
            TextButton(
                onPressed: onResumePressed,
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.black12,
                  size: 46,
                )),
            TextButton(
                onPressed: onStopPressed,
                child: Icon(
                  Icons.stop_circle_outlined,
                  color: Colors.green,
                  size: 46,
                )),
          ],
        ),
      _ => SizedBox(),
    };
  }
}
