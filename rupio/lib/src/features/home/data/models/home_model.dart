import '../../domain/entities/home_entity.dart';

/// Data model for Home feature.
/// Handles JSON serialization and maps to domain entity.
class HomeModel extends HomeEntity {
  const HomeModel({
    required super.id,
    required super.title,
    required super.description,
  });

  /// Creates HomeModel from JSON map.
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  /// Converts HomeModel to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}

