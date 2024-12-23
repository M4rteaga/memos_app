import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
Future<Stream<Uint8List>> fetchConfiguration(Ref ref,) async {

  return Future.value(Stream.empty());
}
