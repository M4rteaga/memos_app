import 'package:flutter/material.dart';
import 'package:memo_app/src/ui/screens/home/home_page.dart';
import 'package:memo_app/src/ui/screens/playback/playback_screen.dart';
import 'package:memo_app/src/ui/screens/recording/recording_page.dart';
import 'package:memo_app/src/ui/screens/vault/vault_page.dart';

class Routes {
  static HomePage goToHomePage(BuildContext context) {
    return HomePage(
      primaryAction: () => goToRecordingPage(context),
      secondaryAction: () => goToVaultPage(context),
    );
  }

  static void goToRecordingPage(BuildContext context) =>
      Navigator.pushNamed(context, RecordingPage.path);

  static RecordingPage recordingPageWidget(BuildContext context) {
    return RecordingPage();
  }

  static void goToVaultPage(BuildContext context) =>
      Navigator.pushNamed(context, VaultPage.path);

  static VaultPage vaultPageWidget(BuildContext context) {
    return VaultPage(
      onRecodPressed: (value) => goToPlaybackPage(context, value),
    );
  }

  static void goToPlaybackPage(BuildContext context, String memoName) async {
    await Navigator.pushNamed(context, PlaybackPage.path, arguments: memoName);
  }

  static PlaybackPage playbackWidget(BuildContext context) {
    final memoName = ModalRoute.of(context)?.settings.arguments as String;

    return PlaybackPage(memoName: memoName);
  }
}
