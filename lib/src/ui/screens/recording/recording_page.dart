import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/screens/recording/models/recording_state_enum.dart';
import 'package:memo_app/src/ui/screens/recording/notifier/recording_controller.dart';
import 'package:memo_app/src/ui/screens/recording/widgets/recording_task_bar.dart';
import 'package:memo_app/src/ui/screens/recording/widgets/recording_visualizer.dart';

import 'widgets/recording_dialog_content.dart';

class RecordingPage extends ConsumerStatefulWidget {
  const RecordingPage({super.key});
  static const path = '/recording';

  @override
  ConsumerState<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends ConsumerState<RecordingPage> {
  final modalInputController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(recordingNotifierProvider, (_, next) {
      if (next.value == RecordingState.end) {
        _showSavingModal(context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Record your idea',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Center(
            child: RecordingVisualizer(),
          ),
          Positioned(
            bottom: 0,
            child: Center(
              child: RecordingTaskBar(),
            ),
          )
        ]),
      ),
    );
  }

  _showSavingModal(context) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return RecordingDialog();
          })
      .whenComplete(() async => await ref
          .read(recordingNotifierProvider.notifier)
          .discardRecording());
}
