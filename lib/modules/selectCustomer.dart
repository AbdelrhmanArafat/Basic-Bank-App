// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparks/components/components.dart';
import 'package:sparks/cubit/cubit.dart';
import 'package:sparks/cubit/states.dart';
import 'package:sparks/modules/allCustomers.dart';
import 'package:sparks/modules/splash.dart';

class SelectCustomer extends StatelessWidget {
  const SelectCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Select Customer',
              style: TextStyle(fontSize: 20),
            ),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                cubit.setReceiverId(index);
                navigateReplacementTo(context,
                    const Splash('Money has been transferred successfully'));
              },
              child: buildCustomerItem(cubit.allCustomer[index], context),
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.allCustomer.length,
          ),
        );
      },
    );
  }
}
