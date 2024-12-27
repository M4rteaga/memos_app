import 'package:fpdart/fpdart.dart';
import 'package:memo_app/src/models/memo_object.dart';
import 'package:memo_app/src/repository/memos_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../models/exceptions.dart';

part 'vault_notifier.g.dart';

@riverpod
class VaultNotifier extends _$VaultNotifier {
  @override
  Future<Either<List<MemoObject>, CustomMemosException>> build() async {
    return await MemosApi.getMemos();
  }
}
