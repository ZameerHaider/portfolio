// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get techStack =>
      throw _privateConstructorUsedError; // Kept so older Firestore docs still parse; no longer rendered.
  List<String> get impactMetrics => throw _privateConstructorUsedError;
  String get liveLink => throw _privateConstructorUsedError;
  int? get order => throw _privateConstructorUsedError;

  /// 'featured' | 'case' | 'more'
  String get tier => throw _privateConstructorUsedError;

  /// e.g. "Client project · Complete system build · Mobile + web"
  String? get meta => throw _privateConstructorUsedError;

  /// Card H3. Falls back to [title] when null.
  String? get headline => throw _privateConstructorUsedError;
  List<String> get highlights => throw _privateConstructorUsedError;

  /// e.g. 'assets/projects/bryde.webp'. A placeholder renders if missing.
  String? get imageAsset => throw _privateConstructorUsedError;
  String? get appStoreLink => throw _privateConstructorUsedError;
  String? get playStoreLink => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call(
      {String id,
      String title,
      String role,
      String description,
      List<String> techStack,
      List<String> impactMetrics,
      String liveLink,
      int? order,
      String tier,
      String? meta,
      String? headline,
      List<String> highlights,
      String? imageAsset,
      String? appStoreLink,
      String? playStoreLink});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? role = null,
    Object? description = null,
    Object? techStack = null,
    Object? impactMetrics = null,
    Object? liveLink = null,
    Object? order = freezed,
    Object? tier = null,
    Object? meta = freezed,
    Object? headline = freezed,
    Object? highlights = null,
    Object? imageAsset = freezed,
    Object? appStoreLink = freezed,
    Object? playStoreLink = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      techStack: null == techStack
          ? _value.techStack
          : techStack // ignore: cast_nullable_to_non_nullable
              as List<String>,
      impactMetrics: null == impactMetrics
          ? _value.impactMetrics
          : impactMetrics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      liveLink: null == liveLink
          ? _value.liveLink
          : liveLink // ignore: cast_nullable_to_non_nullable
              as String,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as String?,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      highlights: null == highlights
          ? _value.highlights
          : highlights // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageAsset: freezed == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      appStoreLink: freezed == appStoreLink
          ? _value.appStoreLink
          : appStoreLink // ignore: cast_nullable_to_non_nullable
              as String?,
      playStoreLink: freezed == playStoreLink
          ? _value.playStoreLink
          : playStoreLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(
          _$ProjectImpl value, $Res Function(_$ProjectImpl) then) =
      __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String role,
      String description,
      List<String> techStack,
      List<String> impactMetrics,
      String liveLink,
      int? order,
      String tier,
      String? meta,
      String? headline,
      List<String> highlights,
      String? imageAsset,
      String? appStoreLink,
      String? playStoreLink});
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(
      _$ProjectImpl _value, $Res Function(_$ProjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? role = null,
    Object? description = null,
    Object? techStack = null,
    Object? impactMetrics = null,
    Object? liveLink = null,
    Object? order = freezed,
    Object? tier = null,
    Object? meta = freezed,
    Object? headline = freezed,
    Object? highlights = null,
    Object? imageAsset = freezed,
    Object? appStoreLink = freezed,
    Object? playStoreLink = freezed,
  }) {
    return _then(_$ProjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      techStack: null == techStack
          ? _value._techStack
          : techStack // ignore: cast_nullable_to_non_nullable
              as List<String>,
      impactMetrics: null == impactMetrics
          ? _value._impactMetrics
          : impactMetrics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      liveLink: null == liveLink
          ? _value.liveLink
          : liveLink // ignore: cast_nullable_to_non_nullable
              as String,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as String?,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      highlights: null == highlights
          ? _value._highlights
          : highlights // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageAsset: freezed == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      appStoreLink: freezed == appStoreLink
          ? _value.appStoreLink
          : appStoreLink // ignore: cast_nullable_to_non_nullable
              as String?,
      playStoreLink: freezed == playStoreLink
          ? _value.playStoreLink
          : playStoreLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl implements _Project {
  const _$ProjectImpl(
      {required this.id,
      required this.title,
      required this.role,
      required this.description,
      required final List<String> techStack,
      final List<String> impactMetrics = const <String>[],
      this.liveLink = '',
      this.order,
      this.tier = 'more',
      this.meta,
      this.headline,
      final List<String> highlights = const <String>[],
      this.imageAsset,
      this.appStoreLink,
      this.playStoreLink})
      : _techStack = techStack,
        _impactMetrics = impactMetrics,
        _highlights = highlights;

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String role;
  @override
  final String description;
  final List<String> _techStack;
  @override
  List<String> get techStack {
    if (_techStack is EqualUnmodifiableListView) return _techStack;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techStack);
  }

// Kept so older Firestore docs still parse; no longer rendered.
  final List<String> _impactMetrics;
// Kept so older Firestore docs still parse; no longer rendered.
  @override
  @JsonKey()
  List<String> get impactMetrics {
    if (_impactMetrics is EqualUnmodifiableListView) return _impactMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_impactMetrics);
  }

  @override
  @JsonKey()
  final String liveLink;
  @override
  final int? order;

  /// 'featured' | 'case' | 'more'
  @override
  @JsonKey()
  final String tier;

  /// e.g. "Client project · Complete system build · Mobile + web"
  @override
  final String? meta;

  /// Card H3. Falls back to [title] when null.
  @override
  final String? headline;
  final List<String> _highlights;
  @override
  @JsonKey()
  List<String> get highlights {
    if (_highlights is EqualUnmodifiableListView) return _highlights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highlights);
  }

  /// e.g. 'assets/projects/bryde.webp'. A placeholder renders if missing.
  @override
  final String? imageAsset;
  @override
  final String? appStoreLink;
  @override
  final String? playStoreLink;

  @override
  String toString() {
    return 'Project(id: $id, title: $title, role: $role, description: $description, techStack: $techStack, impactMetrics: $impactMetrics, liveLink: $liveLink, order: $order, tier: $tier, meta: $meta, headline: $headline, highlights: $highlights, imageAsset: $imageAsset, appStoreLink: $appStoreLink, playStoreLink: $playStoreLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._techStack, _techStack) &&
            const DeepCollectionEquality()
                .equals(other._impactMetrics, _impactMetrics) &&
            (identical(other.liveLink, liveLink) ||
                other.liveLink == liveLink) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.headline, headline) ||
                other.headline == headline) &&
            const DeepCollectionEquality()
                .equals(other._highlights, _highlights) &&
            (identical(other.imageAsset, imageAsset) ||
                other.imageAsset == imageAsset) &&
            (identical(other.appStoreLink, appStoreLink) ||
                other.appStoreLink == appStoreLink) &&
            (identical(other.playStoreLink, playStoreLink) ||
                other.playStoreLink == playStoreLink));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      role,
      description,
      const DeepCollectionEquality().hash(_techStack),
      const DeepCollectionEquality().hash(_impactMetrics),
      liveLink,
      order,
      tier,
      meta,
      headline,
      const DeepCollectionEquality().hash(_highlights),
      imageAsset,
      appStoreLink,
      playStoreLink);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(
      this,
    );
  }
}

abstract class _Project implements Project {
  const factory _Project(
      {required final String id,
      required final String title,
      required final String role,
      required final String description,
      required final List<String> techStack,
      final List<String> impactMetrics,
      final String liveLink,
      final int? order,
      final String tier,
      final String? meta,
      final String? headline,
      final List<String> highlights,
      final String? imageAsset,
      final String? appStoreLink,
      final String? playStoreLink}) = _$ProjectImpl;

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get role;
  @override
  String get description;
  @override
  List<String> get techStack;
  @override // Kept so older Firestore docs still parse; no longer rendered.
  List<String> get impactMetrics;
  @override
  String get liveLink;
  @override
  int? get order;
  @override

  /// 'featured' | 'case' | 'more'
  String get tier;
  @override

  /// e.g. "Client project · Complete system build · Mobile + web"
  String? get meta;
  @override

  /// Card H3. Falls back to [title] when null.
  String? get headline;
  @override
  List<String> get highlights;
  @override

  /// e.g. 'assets/projects/bryde.webp'. A placeholder renders if missing.
  String? get imageAsset;
  @override
  String? get appStoreLink;
  @override
  String? get playStoreLink;
  @override
  @JsonKey(ignore: true)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
