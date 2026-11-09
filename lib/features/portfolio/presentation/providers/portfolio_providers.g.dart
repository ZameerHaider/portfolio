// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dataServiceHash() => r'703079469723b4d36c92277feed7e2897dd5c18a';

/// See also [dataService].
@ProviderFor(dataService)
final dataServiceProvider = AutoDisposeProvider<DataService>.internal(
  dataService,
  name: r'dataServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dataServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DataServiceRef = AutoDisposeProviderRef<DataService>;
String _$projectsHash() => r'16ecd93bcb439768d95d159428ce98dfe508b60a';

/// See also [projects].
@ProviderFor(projects)
final projectsProvider = AutoDisposeStreamProvider<List<Project>>.internal(
  projects,
  name: r'projectsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$projectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProjectsRef = AutoDisposeStreamProviderRef<List<Project>>;
String _$experienceHash() => r'10c9fedce7a2e9e7dbf712ef5003bc2b7eccbf35';

/// See also [experience].
@ProviderFor(experience)
final experienceProvider = AutoDisposeStreamProvider<List<Experience>>.internal(
  experience,
  name: r'experienceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$experienceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExperienceRef = AutoDisposeStreamProviderRef<List<Experience>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
