import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/src/ui/screens/vault/notifier/vault_notifier.dart';
import 'package:memo_app/src/ui/screens/vault/widgets/recording_card.dart';

class VaultPage extends ConsumerWidget {
  static const path = '/vault';
  final ValueChanged<String>? onRecodPressed;
  const VaultPage({super.key, this.onRecodPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(vaultNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Ideas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: switch (asyncValue) {
            AsyncData(:final value) => GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                    value.length,
                    (i) => RecordingCard(
                          data: value[i],
                          onTap: () => onRecodPressed?.call(
                            value[i].name,
                          ),
                        )),
              ),
            AsyncLoading() => Center(child: CircularProgressIndicator()),
            _ => SizedBox(),
          }),
    );
  }
}
