import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparks/components/components.dart';
import 'package:sparks/cubit/cubit.dart';
import 'package:sparks/cubit/states.dart';

class Transfer extends StatelessWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return transferBuilder(cubit.transferData);
      },
      listener: (context, state) {},
    );
  }
}
