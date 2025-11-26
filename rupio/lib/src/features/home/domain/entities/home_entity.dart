import 'package:equatable/equatable.dart';

/// Domain entity for Home feature.
/// Represents the core business data (UI-agnostic).
class HomeEntity extends Equatable {
  final String id;
  final String title;
  final String description;

  const HomeEntity({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, description];
}

