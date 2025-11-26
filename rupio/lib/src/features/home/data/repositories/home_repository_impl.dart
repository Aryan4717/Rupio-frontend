import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

/// Concrete implementation of HomeRepository.
/// Fetches data from remote data source.
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<HomeEntity> getHomeData() async {
    // In real app, you might add caching logic here
    return await remoteDataSource.fetchHomeData();
  }
}

