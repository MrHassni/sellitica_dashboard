import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/models/add_money_model.dart';
import 'package:erp_aspire/provider/shopsProvider.dart';
import 'package:flutter/material.dart';

import '../Configs/Dbkeys.dart';
import '../models/add_money_model.dart';
import '../shared_prefrences/shared_prefrence_functions.dart';

class MoneyProvider with ChangeNotifier {
  List<AddMoneyModel> _allTransactions = [];
  List<AddMoneyModel> allShopsTransactions = [];

  getAllTransactions(shopId) async {
    List<AddMoneyModel> transactions = [];
    String? _company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    await FirebaseFirestore.instance
        .collection('companies')
        .doc(_company)
        .collection('shops')
        .doc(shopId)
        .collection('Transactions')
        .get()
        .then((docs) async {
      for (int i = 0; i < docs.docs.length; i++) {
        AddMoneyModel transactionsData = AddMoneyModel(
            payedTo: docs.docs[i]['payedTo'],
            payedBy: docs.docs[i]['payedBy'],
            paymentMethod: docs.docs[i]['method'],
            amountPayed: docs.docs[i]['amount'],
            timestamp: docs.docs[i][Dbkeys.timestamp]);
        transactions.add(transactionsData);
      }
      _allTransactions = (transactions);
      notifyListeners();
    });
  }

  getTransactions() async {
    List<AddMoneyModel> allTransactionsOfShops = [];
    String? _company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    int timeNow = DateTime.now().millisecondsSinceEpoch;

    var shops = ShopsProvider();

    shops.getShopsDataList().then((val) async {
      for (int index = 0; index < shops.allShops.length; index++) {
        await FirebaseFirestore.instance
            .collection('companies')
            .doc(_company)
            .collection('shops')
            .doc(shops.allShops[index].id)
            .collection('Transactions')
            .get()
            .then((docs) async {
          for (int i = 0; i < docs.docs.length; i++) {
            // log(docs.docs[i].data().toString() +
            //     (timeNow - docs.docs[i][Dbkeys.timestamp]).toString());
            if (timeNow - docs.docs[i][Dbkeys.timestamp] < 2678400000) {
              AddMoneyModel data = AddMoneyModel(
                  payedTo: docs.docs[i]['payedTo'],
                  payedBy: docs.docs[i]['payedBy'],
                  paymentMethod: docs.docs[i]['method'],
                  amountPayed: docs.docs[i]['amount'],
                  timestamp: docs.docs[i][Dbkeys.timestamp]);
              allTransactionsOfShops.add(data);
            }
          }
          allShopsTransactions = (allTransactionsOfShops);
          notifyListeners();
        });
      }
    });
  }

  List<AddMoneyModel> get allTransactions => _allTransactions;
}
