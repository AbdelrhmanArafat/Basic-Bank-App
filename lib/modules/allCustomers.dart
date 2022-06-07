// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparks/components/components.dart';
import 'package:sparks/cubit/cubit.dart';
import 'package:sparks/cubit/states.dart';
import 'package:sparks/modules/customerDetails.dart';

class AllCustomers extends StatelessWidget {
  const AllCustomers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.allCustomer.isEmpty,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          fallback: (context) {
            return Scaffold(
              body: ListView.separated(
                itemCount: cubit.allCustomer.length,
                itemBuilder: (context, index) => GestureDetector(
                  child: buildCustomerItem(cubit.allCustomer[index], context),
                  onTap: () {
                    navigateTo(
                      context,
                      CustomerDetails(index),
                    );
                  },
                ),
                separatorBuilder: (context, index) => myDivider(),
              ),
            );
          },
        );
      },
    );
  }
}
