import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/vault/notifier/vault_notifier.dart';
import 'package:memo_app/src/ui/vault/widgets/recording_card.dart';

class VaultPage extends ConsumerWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(vaultNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ideas'),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: switch (asyncValue) {
            AsyncData(:final value) => GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                    value.length, (i) => RecordingCard(data: value[i])),
              ),
            AsyncLoading() => Center(child: CircularProgressIndicator()),
            _ => SizedBox(),
          }),
    );
  }
}
