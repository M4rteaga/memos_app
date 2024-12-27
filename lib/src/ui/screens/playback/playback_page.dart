import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:memo_app/src/ui/common/error_widget.dart';
import 'package:memo_app/src/ui/common/memos_app_bar.dart';
import 'package:memo_app/src/ui/screens/playback/notifier/read_data_provider.dart';

import '../../../models/exceptions.dart';
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
      appBar: MemosAppBar(title: widget.memoName),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
        child: Center(
            child: switch (asyncValue) {
          AsyncData(:final value) => _handleData(context, value),
          AsyncLoading() => CircularProgressIndicator(),
          _ => SizedBox(),
        }),
      ),
    );
  }

  _handleData(BuildContext context,
      Either<Stream<List<int>>, CustomMemosException> data) {
    return data.match(
      (value) => PlayerWidget(
        player: player,
        mediaData: value,
      ),
      (e) => CustomErrorWidget(exception: e),
    );
  }
}
