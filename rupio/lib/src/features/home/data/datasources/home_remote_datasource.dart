import '../models/home_model.dart';

/// Abstract data source for fetching home data remotely.
abstract class HomeRemoteDataSource {
  Future<HomeModel> fetchHomeData();
}

/// Implementation of HomeRemoteDataSource.
/// In production, this would make HTTP calls.
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<HomeModel> fetchHomeData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return dummy data (replace with actual API call)
    return const HomeModel(
      id: '1',
      title: 'Welcome to Rupio!',
      description: 'Your clean architecture Flutter app is ready.',
    );
  }
}

