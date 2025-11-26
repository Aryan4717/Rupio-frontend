import 'package:flutter/material.dart';
import 'src/core/di/di_container.dart';
import 'src/core/ui/app.dart';

/// Entry point of the Rupio application.
/// Initializes dependency injection and launches the app.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection
  setupDependencies();
  
  runApp(const RupioApp());
}
