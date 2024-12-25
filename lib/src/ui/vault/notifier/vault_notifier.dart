import 'package:memo_app/src/models/memo_object.dart';
import 'package:memo_app/src/repository/memo_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vault_notifier.g.dart';

@riverpod
class VaultNotifier extends _$VaultNotifier {
  @override
  Future<List<MemoObject>> build() async {

    return await MemoApi.getMemos();
  }
}
