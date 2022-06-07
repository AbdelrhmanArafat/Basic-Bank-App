import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparks/components/components.dart';
import 'package:sparks/cubit/cubit.dart';
import 'package:sparks/cubit/states.dart';
import 'package:sparks/layout/home_layout.dart';

class Splash extends StatefulWidget {
  final String title;

  const Splash(this.title, {Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState(title);
}

class _SplashState extends State<Splash> {
  final String title;
  _SplashState(this.title);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goTo();
  }

  void goTo() async {
    if (title.compareTo('Money has been transferred successfully') == 0) {
      AppCubit cubit = AppCubit.get(context);
      await cubit.updateDatabase();
      await cubit.getDataFromDatabase();
      await cubit.insertTransfersToDatabase();
      await Future.delayed(const Duration(milliseconds: 1000), () {});
      navigateReplacementTo(context, const HomeLayout());
    } else {
      await Future.delayed(const Duration(milliseconds: 2000), () {});
      navigateReplacementTo(context, const HomeLayout());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.blue,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
