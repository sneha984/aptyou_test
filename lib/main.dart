import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/commons/global_variables/global_variables.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/authentication/bloc/auth_bloc.dart';
import 'features/authentication/repository/auth_repository.dart';
import 'features/review/bloc/review_bloc.dart';
import 'features/review/bloc/review_event.dart';
import 'features/review/repository/review_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository(Dio());
  final ReviewRepository reviewRepository = ReviewRepository(Dio());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authRepository),
        ),
        BlocProvider(
          create: (_) => ReviewBloc(reviewRepository)..add(LoadAssets()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Letter Detective',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const SplashScreen(),
      ),
    );
  }
}
