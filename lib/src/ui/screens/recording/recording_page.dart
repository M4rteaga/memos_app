import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/screens/recording/models/recording_state_enum.dart';
import 'package:memo_app/src/ui/screens/recording/notifier/recording_controller.dart';
import 'package:memo_app/src/ui/screens/recording/widgets/recording_task_bar.dart';
import 'package:memo_app/src/ui/screens/recording/widgets/recording_visualizer.dart';

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
    modalInputController.dispose();
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
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(maxHeight: 350),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Save memo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'How should we call your idea ?',
                            textAlign: TextAlign.center,
                          ),
                          TextField(
                            controller: modalInputController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9a-zA-Z]")),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Row(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () => {
                                      ref
                                          .read(recordingNotifierProvider
                                              .notifier)
                                          .discardRecording()
                                    },
                                child: Text(
                                  'Discard',
                                )),
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.indigo)),
                                onPressed: () => {
                                      ref
                                          .read(recordingNotifierProvider
                                              .notifier)
                                          .saveRecording(
                                              modalInputController.text)
                                    },
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).whenComplete(() {
        print("se cerro el modal que hacemos ahi ??");
      });
}
