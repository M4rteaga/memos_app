import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/vault/notifier/read_data_provider.dart';

import 'widgets/player.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  const PlayerScreen({super.key, required this.memoName});
  final String memoName;

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
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
        title: Text(widget.memoName),
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
