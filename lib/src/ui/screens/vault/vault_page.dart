import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:memo_app/src/models/memo_object.dart';
import 'package:memo_app/src/ui/common/error_widget.dart';
import 'package:memo_app/src/ui/screens/vault/notifier/vault_notifier.dart';
import 'package:memo_app/src/ui/screens/vault/widgets/recording_card.dart';

import '../../../models/exceptions.dart';

class VaultPage extends ConsumerStatefulWidget {
  static const path = '/vault';
  final ValueChanged<String>? onRecodPressed;
  const VaultPage({super.key, this.onRecodPressed});

  @override
  ConsumerState<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends ConsumerState<VaultPage> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            AsyncData(:final value) => _handleData(context, value),
            AsyncLoading() => Center(child: CircularProgressIndicator()),
            _ => SizedBox(),
          }),
    );
  }

  _handleData(BuildContext context,
      Either<List<MemoObject>, CustomMemosException> data) {
    return data.match(
        (value) => GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                  value.length,
                  (i) => RecordingCard(
                        data: value[i],
                        onTap: () => widget.onRecodPressed?.call(
                          value[i].name,
                        ),
                      )),
            ),
        (e) => CustomErrorWidget(
              exception: e,
            ));
  }
}
