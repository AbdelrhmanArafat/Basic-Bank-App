// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparks/components/components.dart';
import 'package:sparks/cubit/cubit.dart';
import 'package:sparks/cubit/states.dart';
import 'package:sparks/model/user_data.dart';
import 'package:sparks/modules/selectCustomer.dart';

class CustomerDetails extends StatelessWidget {
  final int id;
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  final TextStyle style1 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black);
  final TextStyle style2 = const TextStyle(
      fontWeight: FontWeight.normal, fontSize: 20, color: Colors.blueGrey);

  CustomerDetails(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        UserData user = cubit.allCustomer[id];
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Customer Details',
              style: TextStyle(fontSize: 20),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(
                    Icons.person,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  //Row of account number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Account Number: ',
                        style: style1,
                      ),
                      Text(
                        '${user.id}',
                        style: style2,
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  //Row of Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Name: ',
                        style: style1,
                      ),
                      Text(
                        user.name,
                        style: style2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  //Row of Email
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email: ',
                        style: style1,
                      ),
                      Text(
                        user.email,
                        style: style2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  //Row of balance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Balance: ',
                        style: style1,
                      ),
                      Text(
                        '${user.balance}',
                        style: style2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      cubit.showForm();
                    },
                    child: const Text(
                      'Transfer money',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Visibility(
                    visible: cubit.isShow,
                    child: Form(
                      key: formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 200,
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid amount';
                                }
                                if (int.parse(value) > user.balance) {
                                  return 'Insufficient balance';
                                }
                                return null;
                              },
                              controller: controller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Amount',
                                hintText: 'Enter amount',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              cubit.isShow = false;
                              if (formKey.currentState!.validate()) {
                                cubit.setTransferAmount(
                                    double.parse(controller.text));
                                cubit.setSenderId(id);
                                navigateTo(
                                  context,
                                  const SelectCustomer(),
                                );
                              }
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.send,
                                  size: 25,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Transfer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
