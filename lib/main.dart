import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/routes/routes.dart';

import 'src/logger.dart';
import 'src/ui/recording/recording_page.dart';
import 'src/ui/home/home_page.dart';
import 'src/ui/vault/vault_page.dart';

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
        RecordingPage.path: Routes.goToRecordingPage,
        VaultPage.path: Routes.goToVaultPage
      },
    );
  }
}
