import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/recording/models/recording_state_enum.dart';
import 'package:memo_app/src/ui/recording/notifier/recording_controller.dart';
import 'package:memo_app/src/ui/recording/widgets/recording_task_bar.dart';
import 'package:memo_app/src/ui/recording/widgets/recording_visualizer.dart';

class RecordingPage extends ConsumerStatefulWidget {
  const RecordingPage({super.key});

  @override
  ConsumerState<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends ConsumerState<RecordingPage> {
  final modalInputController = TextEditingController();

  @override
  void dispose() {
    modalInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(recordingNotifierProvider, (_, next) {
      if (next.value?.recordingState == RecordingState.end) {
        _showSavingModal(context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Record your idea'),
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
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Save memo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text('How do you whant to call your recording'),
                  TextField(
                    controller: modalInputController,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => {
                                ref
                                    .read(recordingNotifierProvider.notifier)
                                    .saveRecording(modalInputController.text)
                              },
                          child: Text('Save')),
                      ElevatedButton(
                          onPressed: () => {}, child: Text('Discard')),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
