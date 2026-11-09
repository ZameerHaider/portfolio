import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String title,
    required String role,
    required String description,
    required List<String> techStack,
    // Kept so older Firestore docs still parse; no longer rendered.
    @Default(<String>[]) List<String> impactMetrics,
    @Default('') String liveLink,
    int? order,

    /// 'featured' | 'case' | 'more'
    @Default('more') String tier,

    /// e.g. "Client project · Complete system build · Mobile + web"
    String? meta,

    /// Card H3. Falls back to [title] when null.
    String? headline,
    @Default(<String>[]) List<String> highlights,

    /// e.g. 'assets/projects/bryde.webp'. A placeholder renders if missing.
    String? imageAsset,
    String? appStoreLink,
    String? playStoreLink,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
