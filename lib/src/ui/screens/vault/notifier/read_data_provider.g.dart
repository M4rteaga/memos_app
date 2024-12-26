// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$readDataProviderHash() => r'b7ffe52227a48b04c4024b53bc5f66acc0ac7b8a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [readDataProvider].
@ProviderFor(readDataProvider)
const readDataProviderProvider = ReadDataProviderFamily();

/// See also [readDataProvider].
class ReadDataProviderFamily extends Family<AsyncValue<Stream<List<int>>>> {
  /// See also [readDataProvider].
  const ReadDataProviderFamily();

  /// See also [readDataProvider].
  ReadDataProviderProvider call(
    String fileName,
  ) {
    return ReadDataProviderProvider(
      fileName,
    );
  }

  @override
  ReadDataProviderProvider getProviderOverride(
    covariant ReadDataProviderProvider provider,
  ) {
    return call(
      provider.fileName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'readDataProviderProvider';
}

/// See also [readDataProvider].
class ReadDataProviderProvider
    extends AutoDisposeFutureProvider<Stream<List<int>>> {
  /// See also [readDataProvider].
  ReadDataProviderProvider(
    String fileName,
  ) : this._internal(
          (ref) => readDataProvider(
            ref as ReadDataProviderRef,
            fileName,
          ),
          from: readDataProviderProvider,
          name: r'readDataProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$readDataProviderHash,
          dependencies: ReadDataProviderFamily._dependencies,
          allTransitiveDependencies:
              ReadDataProviderFamily._allTransitiveDependencies,
          fileName: fileName,
        );

  ReadDataProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fileName,
  }) : super.internal();

  final String fileName;

  @override
  Override overrideWith(
    FutureOr<Stream<List<int>>> Function(ReadDataProviderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReadDataProviderProvider._internal(
        (ref) => create(ref as ReadDataProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fileName: fileName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Stream<List<int>>> createElement() {
    return _ReadDataProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReadDataProviderProvider && other.fileName == fileName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fileName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReadDataProviderRef on AutoDisposeFutureProviderRef<Stream<List<int>>> {
  /// The parameter `fileName` of this provider.
  String get fileName;
}

class _ReadDataProviderProviderElement
    extends AutoDisposeFutureProviderElement<Stream<List<int>>>
    with ReadDataProviderRef {
  _ReadDataProviderProviderElement(super.provider);

  @override
  String get fileName => (origin as ReadDataProviderProvider).fileName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
