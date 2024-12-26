import 'package:flutter/material.dart';
import 'package:memo_app/src/ui/home/home_page.dart';
import 'package:memo_app/src/ui/recording/recording_page.dart';
import 'package:memo_app/src/ui/vault/vault_page.dart';

class Routes {
  static HomePage goToHomePage(BuildContext context) {
    return HomePage(
      primaryAction: () => Navigator.pushNamed(context, RecordingPage.path),
      secondaryAction: () => Navigator.pushNamed(context, VaultPage.path),
    );
  }

  static RecordingPage goToRecordingPage(BuildContext context) {
    return RecordingPage();
  }

  static VaultPage goToVaultPage(BuildContext context) {
    return VaultPage();
  }
}
