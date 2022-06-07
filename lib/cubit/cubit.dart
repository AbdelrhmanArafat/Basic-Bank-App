// ignore_for_file: avoid_print, unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparks/model/transfer_data.dart';
import 'package:sparks/model/user_data.dart';
import 'package:sparks/modules/transfer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sparks/cubit/states.dart';
import 'package:sparks/modules/allCustomers.dart';
import '../components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isShow = false;
  String title = '';
  int currentIndex = 0;
  int senderID = 0;
  int receiverID = 0;
  double transferAmount = 0;
  List<UserData> allCustomer = [];
  List<TransferData> transferData = [];
  List<String> titles = ['All Customers', 'Transfers'];
  late Database database;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void showForm() {
    isShow = !isShow;
    emit(AppShowFormState());
  }

  void setTransferAmount(double amount) {
    transferAmount = amount;
  }

  void setSenderId(id) {
    senderID = id;
  }

  void setReceiverId(id) {
    receiverID = id;
  }

  List<Widget> screens = [
    const AllCustomers(),
    const Transfer(),
  ];

  void createDatabase() async {
    await openDatabase('bank.db', version: 1,
        onCreate: (Database db, version) async {
      await db.execute(userTableQuery).then((value) => print('table created'));
      await db
          .execute(transferTableQuery)
          .then((value) => debugPrint('table created'))
          .then((value) async {
        debugPrint('Database is created');
      });
    }, onOpen: (db) async {
      debugPrint('database opened');
    }).then((value) async {
      database = value;
      emit(AppCreateDatabaseState());
      await insertDatabase();
      await getTransfersFromDatabase();
      debugPrint('the length is ${allCustomer.length}');
    });
  }

  Future<void> getDataFromDatabase() async {
    emit(AppDatabaseLoadingState());
    await database.rawQuery('SELECT * FROM users').then((value) {
      log('$value get data successfully');
      allCustomer.clear();
      for (Map element in value) {
        UserData user = UserData(
            id: element['id'],
            name: element['name'],
            email: element['email'],
            balance: element['balance']);
        allCustomer.add(user);
      }
      emit(AppGetDatabaseState());
    });
  }

  Future<void> insertDatabase() async {
    await getDataFromDatabase();
    emit(AppDatabaseLoadingState());
    if (allCustomer.isEmpty) {
      await database.transaction((txn) {
        var id1 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("abdelrhman arafat", "abdelrhman@gmail.com", 45000)');
        var id2 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("ahmed magdy", "ahmed@gmail.com", 50000)');
        var id3 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("mohamed emad", "mohamed@hotmail.com", 55000)');
        var id4 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("mahmoud ahmed", "mahmoud@hotmail.com", 60000)');
        var id5 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("islam mohamed", "islam@outlook.com", 65000)');
        var id6 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("ismail ahmed","ismail@outlook.com", 70000)');
        var id7 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("basam ahmed", "basam@yahoo.com", 75000)');
        var id8 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("wala mohamed", "wala@yahoo.com", 80000)');
        var id9 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("salah mohamed", "salah@gmail.com", 85000)');
        var id10 = txn.rawInsert(
            'INSERT INTO users(name, email, balance) VALUES("khaled salah", "khaled@gmail.com", 90000)');
        return id1;
      }).then((value) {
        emit(AppInsertDatabaseState());
        getDataFromDatabase();
      });
    }
  }

  Future<void> getTransfersFromDatabase() async {
    transferData.clear();
    await database.rawQuery('SELECT * FROM transfer').then((value) {
      for (Map element in value) {
        int sId = element['senderId'];
        int rId = element['receiverId'];
        TransferData transfer = TransferData(
            senderName: allCustomer[sId].name,
            senderBalance: allCustomer[sId].balance,
            receiverName: allCustomer[rId].name,
            receiverBalance: allCustomer[rId].balance,
            amount: element['amount']);
        transferData.add(transfer);
      }
      emit(AppGetTransferDatabaseState());
    });
  }

  Future<void> insertTransfersToDatabase() async {
    await database.transaction((txn) {
      var id1 = txn
          .rawInsert(
              'INSERT INTO transfer(senderId,receiverId,amount) VALUES($senderID,$receiverID,$transferAmount)')
          .then((value) => print(value));
      return id1;
    }).then((value) {
      print('transfer added');
      emit(AppInsertDatabaseState());
      getTransfersFromDatabase();
    });
  }

  Future<void> updateDatabase() async {
    double newSenderBalance = allCustomer[senderID].balance - transferAmount;
    double newReceiverBalance =
        allCustomer[receiverID].balance + transferAmount;
    print(
        '$senderID $receiverID ${allCustomer[senderID].balance} ${allCustomer[receiverID].balance}');
    await database.rawUpdate('UPDATE users SET balance = ? WHERE id = ?',
        [newSenderBalance, senderID + 1]);
    await database.rawUpdate('UPDATE users SET balance = ? WHERE id = ?',
        [newReceiverBalance, receiverID + 1]).then((value) async {
      emit(AppUpdateDatabaseState());
    });
  }
}//class AppCubit
