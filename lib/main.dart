import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/routes/routes.dart';
import 'package:memo_app/src/ui/screens/playback/playback_page.dart';

import 'src/logger.dart';
import 'src/ui/screens/recording/recording_page.dart';
import 'src/ui/screens/vault/vault_page.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [Logger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routes: {
        '/': Routes.goToHomePage,
        RecordingPage.path: Routes.recordingPageWidget,
        VaultPage.path: Routes.vaultPageWidget,
        PlaybackPage.path: Routes.playbackWidget,
      },
    );
  }
}
