import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/recording/notifier/recording_controller.dart';

import '../models/recording_state_enum.dart';

class RecordingVisualizer extends ConsumerStatefulWidget {
  const RecordingVisualizer({super.key});

  @override
  ConsumerState<RecordingVisualizer> createState() =>
      _RecordingVisualizerState();
}

class _RecordingVisualizerState extends ConsumerState<RecordingVisualizer> {
  final List<double> _initialHeights = [0.01, 0.01, 0.01, 0.01, 0.01];
  final List<double> _heights = [0.05, 0.07, 0.1, 0.07, 0.05];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimating() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        // This is a simple way to rotate the list, creating a wave effect.
        _heights.add(_heights.removeAt(0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(recordingNotifierProvider, (_, next) {
      if (next.value == RecordingState.recording) {
        _startAnimating();
      } else {
        _timer?.cancel();
      }
    });
    final asyncData = ref.watch(recordingNotifierProvider);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: switch (asyncData) {
          AsyncData(:final value) => switch (value) {
              RecordingState.none ||
              RecordingState.paused ||
              RecordingState.end =>
                _initialHeights.map((height) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 20,
                    height: MediaQuery.sizeOf(context).height * height,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  );
                }).toList() as List<Widget>,
              RecordingState.recording => _heights.map((height) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 20,
                    height: MediaQuery.sizeOf(context).height * height,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  );
                }).toList() as List<Widget>,
            },
          _ => [
              SizedBox(),
            ],
        },
      ),
    );
  }
}
