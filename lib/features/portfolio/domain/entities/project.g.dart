// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      role: json['role'] as String,
      description: json['description'] as String,
      techStack:
          (json['techStack'] as List<dynamic>).map((e) => e as String).toList(),
      impactMetrics: (json['impactMetrics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      liveLink: json['liveLink'] as String? ?? '',
      order: (json['order'] as num?)?.toInt(),
      tier: json['tier'] as String? ?? 'more',
      meta: json['meta'] as String?,
      headline: json['headline'] as String?,
      highlights: (json['highlights'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      imageAsset: json['imageAsset'] as String?,
      appStoreLink: json['appStoreLink'] as String?,
      playStoreLink: json['playStoreLink'] as String?,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'role': instance.role,
      'description': instance.description,
      'techStack': instance.techStack,
      'impactMetrics': instance.impactMetrics,
      'liveLink': instance.liveLink,
      'order': instance.order,
      'tier': instance.tier,
      'meta': instance.meta,
      'headline': instance.headline,
      'highlights': instance.highlights,
      'imageAsset': instance.imageAsset,
      'appStoreLink': instance.appStoreLink,
      'playStoreLink': instance.playStoreLink,
    };
