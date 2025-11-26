import '../entities/home_entity.dart';

/// Abstract repository interface for Home feature.
/// Defines the contract that data layer must implement.
abstract class HomeRepository {
  /// Fetches home data from data source.
  Future<HomeEntity> getHomeData();
}

