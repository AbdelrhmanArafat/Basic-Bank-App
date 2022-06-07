import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparks/cubit/cubit.dart';
import 'package:sparks/cubit/states.dart';
import 'package:sparks/modules/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Splash('Spark Bank'),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
