class MemoObject {
  MemoObject({
    required this.id,
    required this.name,
    required this.size,
  }) {
    name = name.split('/').last;
  }

  final String id;
   String name;
  final int size;
}
