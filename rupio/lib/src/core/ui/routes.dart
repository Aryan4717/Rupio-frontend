import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_page.dart';

/// Centralized routing configuration.
/// Defines all named routes and handles route generation.
class AppRoutes {
  // Route names
  static const String home = '/';
  static const String settings = '/settings';

  /// Generates routes based on RouteSettings.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      // Add more routes here as needed
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

