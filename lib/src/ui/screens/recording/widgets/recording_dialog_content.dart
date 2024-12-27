import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/recording_state_enum.dart';
import '../notifier/recording_controller.dart';

class RecordingDialog extends ConsumerStatefulWidget {
  const RecordingDialog({super.key});

  @override
  ConsumerState<RecordingDialog> createState() => _RecordingDialogState();
}

class _RecordingDialogState extends ConsumerState<RecordingDialog> {
  final modalInputController = TextEditingController();
  @override
  void dispose() {
    modalInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(recordingNotifierProvider);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        constraints: BoxConstraints(maxHeight: 350),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: switch (asyncData) {
            AsyncData(:final value) => switch (value) {
                RecordingState.uploading => CircularProgressIndicator(),
                RecordingState.susccesfulyUpload => Center(
                    child: Text(
                        'Succesfuly saved ${modalInputController.text}.wav'),
                  ),
                _ => Stack(
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
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Discard',
                                )),
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.indigo)),
                                onPressed: () => ref
                                    .read(recordingNotifierProvider.notifier)
                                    .saveRecording(modalInputController.text),
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
              },
            _ => SizedBox(),
          },
        ),
      ),
    );
  }
}
