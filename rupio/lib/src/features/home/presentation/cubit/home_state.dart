import 'package:equatable/equatable.dart';
import '../../domain/entities/home_entity.dart';

/// Base state class for Home feature.
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action.
class HomeInitial extends HomeState {}

/// Loading state while fetching data.
class HomeLoading extends HomeState {}

/// Loaded state with data.
class HomeLoaded extends HomeState {
  final HomeEntity data;

  const HomeLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

/// Error state with message.
class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}

