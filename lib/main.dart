
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/core/app_router.dart';
import 'package:tentwenty_task/core/app_theme.dart';
import 'package:tentwenty_task/features/movies/bloc/movies_bloc.dart';
import 'package:tentwenty_task/features/movies/repository/movies_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => MoviesBloc(MoviesRepository()))],
      child: MaterialApp(
        title: 'Tentwenty',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.home,
      ),
    );
  }
}
