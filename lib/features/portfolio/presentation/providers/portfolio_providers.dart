import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/experience.dart';
import '../../data/repositories/firestore_portfolio_repository.dart';
import '../../data/repositories/json_portfolio_repository.dart';
import '../../data/repositories/data_service.dart';

part 'portfolio_providers.g.dart';

@riverpod
DataService dataService(DataServiceRef ref) {
  return DataService(
    firestoreRepo: FirestorePortfolioRepository(),
    jsonRepo: JsonPortfolioRepository(),
    // Live Firestore by default. For local checks against the JSON seed:
    // flutter run --dart-define=USE_FIRESTORE=false
    useFirestore: const bool.fromEnvironment('USE_FIRESTORE', defaultValue: true),
  );
}

@riverpod
Stream<List<Project>> projects(ProjectsRef ref) {
  return ref.watch(dataServiceProvider).streamProjects();
}

@riverpod
Stream<List<Experience>> experience(ExperienceRef ref) {
  return ref.watch(dataServiceProvider).streamExperience();
}
