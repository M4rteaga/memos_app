import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:memo_app/src/repository/memos_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../models/exceptions.dart';

part 'read_data_provider.g.dart';

@riverpod
Future<Either<Stream<List<int>>,CustomMemosException>> readDataProvider(Ref ref, String fileName) async {
  return await MemosApi.getMemosData(fileName);
}
