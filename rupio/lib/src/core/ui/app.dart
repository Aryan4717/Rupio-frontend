import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/di_container.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import 'routes.dart';
import 'theme.dart';

/// Root widget of the Rupio application.
/// Sets up MaterialApp with theme, routing, and global providers.
class RupioApp extends StatelessWidget {
  const RupioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => getIt<HomeCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Rupio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

