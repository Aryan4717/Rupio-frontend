import 'package:get_it/get_it.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

/// Global GetIt instance for dependency injection.
final GetIt getIt = GetIt.instance;

/// Registers all dependencies.
/// Call this in main.dart before runApp().
void setupDependencies() {
  // Data Sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetHomeDataUseCase>(
    () => GetHomeDataUseCase(repository: getIt()),
  );

  // Cubits / Blocs
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getHomeDataUseCase: getIt()),
  );
}

