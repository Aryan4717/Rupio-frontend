import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';

/// Centralized routing configuration.
/// Defines all named routes and handles route generation.
class AppRoutes {
  // Route names
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String welcome = '/welcome';
  static const String dashboard = '/dashboard';
  static const String settings = '/settings';

  /// Generates routes based on RouteSettings.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupPage(),
        );
      case welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        );
      case dashboard:
        // TODO: Create dashboard page
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Dashboard - Coming Soon')),
          ),
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

