import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

/// Use case for fetching home data.
/// Encapsulates business logic for this operation.
class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase({required this.repository});

  /// Executes the use case and returns HomeEntity.
  Future<HomeEntity> execute() async {
    return await repository.getHomeData();
  }
}

