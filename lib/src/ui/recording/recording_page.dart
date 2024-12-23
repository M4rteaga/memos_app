import 'package:flutter/material.dart';
import 'package:memo_app/src/ui/recording/widgets/recording_task_bar.dart';
import 'package:memo_app/src/ui/recording/widgets/recording_visualizer.dart';

class RecordingPage extends StatelessWidget {
  const RecordingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
}
