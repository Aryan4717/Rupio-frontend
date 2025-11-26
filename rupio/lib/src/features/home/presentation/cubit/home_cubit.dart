import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import 'home_state.dart';

/// HomeCubit manages the state for the Home feature.
/// Uses GetHomeDataUseCase to fetch data.
class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeCubit({required this.getHomeDataUseCase}) : super(HomeInitial());

  /// Fetches home data and emits appropriate states.
  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final data = await getHomeDataUseCase.execute();
      emit(HomeLoaded(data: data));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}

