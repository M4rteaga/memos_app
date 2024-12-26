import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/screens/vault/notifier/read_data_provider.dart';

import 'widgets/player.dart';

class PlaybackPage extends ConsumerStatefulWidget {
  const PlaybackPage({super.key, required this.memoName});
  final String memoName;
  static const path = '/playback';

  @override
  ConsumerState<PlaybackPage> createState() => _PlaybackPageState();
}

class _PlaybackPageState extends ConsumerState<PlaybackPage> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(ReadDataProviderProvider(widget.memoName));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.memoName,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: switch (asyncValue) {
        AsyncData(:final value) => PlayerWidget(
            player: player,
            mediaData: value,
          ),
        AsyncLoading() => CircularProgressIndicator(),
        _ => SizedBox(),
      }),
    );
  }
}
