import 'package:flutter/material.dart';
import 'package:sparks/model/transfer_data.dart';
import 'package:sparks/model/user_data.dart';

Widget buildCustomerItem(UserData model, context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      leading: const Icon(
        Icons.person,
        color: Colors.blue,
      ),
      title: Text(
        model.name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        model.email,
        overflow: TextOverflow.visible,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'BALANCE:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${model.balance}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customerBuilder(List<UserData> customer, Function onTap) {
  return ListView.separated(
    itemBuilder: (context, index) => GestureDetector(
      onTap: onTap(),
      child: buildCustomerItem(customer[index], context),
    ),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: customer.length,
  );
}

Widget buildTransferItem(TransferData model, context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                model.senderName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              const Icon(
                Icons.person,
                size: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$ ${model.senderBalance}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Icon(
                Icons.arrow_forward,
                size: 50,
                color: Colors.deepPurple,
              ),
              Text(
                '\$ ${model.amount}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                model.receiverName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              const Icon(
                Icons.person,
                size: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$ ${model.receiverBalance}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget transferBuilder(List<TransferData> transfer) {
  return ListView.separated(
    itemBuilder: (context, index) =>
        buildTransferItem(transfer[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: transfer.length,
  );
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[400],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateReplacementTo(context, widget) =>
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
