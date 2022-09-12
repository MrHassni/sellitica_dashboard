import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/shared_prefrences/shared_prefrence_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Configs/Dbkeys.dart';
import '../Configs/Dbpaths.dart';
import '../models/orderDetailsModel.dart';

class OrderProvider extends ChangeNotifier {
  List<orderModel> pendingOrdermodel = [];
  List<orderModel> inprocessOrdermodel = [];
  List<orderModel> completedOrdermodel = [];
  List<OrderDetailsModel> allOrderDetails = [];
  bool isDataLoaded = false;

  List<orderModel> pendingOrdermodelforSpecificRetailer = [];
  List<orderModel> inprocessOrdermodelforSpecificRetailer = [];
  List<orderModel> completedOrdermodelforSpecificRetailer = [];
  List<orderModel> allOrdermodelforSpecificRetailer = [];

  List<orderModel> completedUserOrderModel = [];
  List<orderModel> pendingUserOrderModel = [];
  List<orderModel> inProgressUserOrderModel = [];

  misDataLoaded(bool val) {
    isDataLoaded = val;
    notifyListeners();
  }

  int selectedTabBarIndex = 0;

  tabBarIndex(int index) {
    selectedTabBarIndex = index;
    notifyListeners();
  }

  getUserOrdersDataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _companyId = pref.getString(Dbkeys.company)!;
    String _email = pref.getString(Dbkeys.email)!;

    var firestoreInstance = FirebaseFirestore.instance;
    List<orderModel> pendingmodel = [];
    List<orderModel> inprocessmodel = [];
    List<orderModel> completedmodel = [];

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: _email)
        .where(Dbkeys.status, isEqualTo: 0)
        .get()
        .then((docs) async {
      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
          );
          pendingmodel.add(userModel);
        }
      }
    });

    /*
    IN PROCESS ORDERS
    */

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: _email)
        .where(Dbkeys.status, isEqualTo: 1)
        .get()
        .then((docs) async {
      //  ordermodel.clear();

      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
            // orderdetailModel: []
          );
          inprocessmodel.add(userModel);
          // print(docs.docs[i][Dbkeys.phone]);
          // firestoreInstance
          //     .collection(DbPaths.companies)
          //     .doc(_companyId)
          //     .collection(DbPaths.orders)
          //     .doc(docs.docs[i].get(Dbkeys.orderid))
          //     .collection(DbPaths.orderdetails)
          //     .get()
          //     .then((docs) async {
          //   print("IN FOR");
          //   // print(docs.docs[0].metadata.toString());
          //   print(docs.docs.length.toString());
          // });
        }
      }
    });

    /*
    COMPLETED ORDERS
    */

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: _email)
        .where(Dbkeys.status, isEqualTo: 2)
        .get()
        .then((docs) async {
      //  ordermodel.clear();

      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
            // orderdetailModel: []
          );
          completedmodel.add(userModel);
          // print(docs.docs[i][Dbkeys.phone]);
          // firestoreInstance
          //     .collection(DbPaths.companies)
          //     .doc(_companyId)
          //     .collection(DbPaths.orders)
          //     .doc(docs.docs[i].get(Dbkeys.orderid))
          //     .collection(DbPaths.orderdetails)
          //     .get()
          //     .then((docs) async {
          //   print("IN FOR");
          //   // print(docs.docs[0].metadata.toString());
          //   print(docs.docs.length.toString());
          // });
        }
      }
    });

    pendingUserOrderModel = pendingmodel;
    inProgressUserOrderModel = inprocessmodel;
    completedUserOrderModel = completedmodel;
    isDataLoaded = true;
    notifyListeners();
  }

  List<orderModel> get pendingOrdersOfUser => pendingUserOrderModel;
  List<orderModel> get inProgressOrdersOfUser => inProgressUserOrderModel;
  List<orderModel> get completeOrdersOfUser => completedUserOrderModel;

  getSpecificRetailerOrdersDataList(
      {required String shopID, required String email}) async {
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    // print("log.d");
    // print(_companyId);

    var firestoreInstance = await FirebaseFirestore.instance;
    List<orderModel> pendingmodel = [];
    List<orderModel> inprocessmodel = [];
    List<orderModel> completedmodel = [];
    List<orderModel> allmodel = [];

    /*
    PENDING ORDERS
    */

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: email)
        .where(Dbkeys.status, isEqualTo: 0)
        .where(Dbkeys.shopid, isEqualTo: shopID)
        .get()
        .then((docs) async {
      //  ordermodel.clear();

      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
            // orderdetailModel: []
          );
          pendingmodel.add(userModel);
          // print(docs.docs[i][Dbkeys.phone]);
          // firestoreInstance
          //     .collection(DbPaths.companies)
          //     .doc(_companyId)
          //     .collection(DbPaths.orders)
          //     .doc(docs.docs[i].get(Dbkeys.orderid))
          //     .collection(DbPaths.orderdetails)
          //     .get()
          //     .then((docs) async {
          //   print("IN FOR");
          //   // print(docs.docs[0].metadata.toString());
          //   print(docs.docs.length.toString());
          // });
        }
      }

      // print("doc length" + docs.docs.length.toString());
      // // print(docs.docs[0].data().containsKey(''));
      // print(docs.docs[0].id);
      // print("model length" + ordermodel.length.toString());
      // print(ordermodel);
      // print(ordermodel[0].numberofproducts);
    });

    /*
    IN PROCESS ORDERS
    */

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: email)
        .where(Dbkeys.status, isEqualTo: 1)
        .where(Dbkeys.shopid, isEqualTo: shopID)
        .get()
        .then((docs) async {
      //  ordermodel.clear();

      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
            // orderdetailModel: []
          );
          inprocessmodel.add(userModel);
          // print(docs.docs[i][Dbkeys.phone]);
          // firestoreInstance
          //     .collection(DbPaths.companies)
          //     .doc(_companyId)
          //     .collection(DbPaths.orders)
          //     .doc(docs.docs[i].get(Dbkeys.orderid))
          //     .collection(DbPaths.orderdetails)
          //     .get()
          //     .then((docs) async {
          //   print("IN FOR");
          //   // print(docs.docs[0].metadata.toString());
          //   print(docs.docs.length.toString());
          // });
        }
      }

      // print("doc length" + docs.docs.length.toString());
      // // print(docs.docs[0].data().containsKey(''));
      // print(docs.docs[0].id);
      // print("model length" + ordermodel.length.toString());
      // print(ordermodel);
      // print(ordermodel[0].numberofproducts);
    });

    /*
    COMPLETED ORDERS
    */

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: email)
        .where(Dbkeys.status, isEqualTo: 2)
        .where(Dbkeys.shopid, isEqualTo: shopID)
        .get()
        .then((docs) async {
      //  ordermodel.clear();

      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
            // orderdetailModel: []
          );
          completedmodel.add(userModel);
          // print(docs.docs[i][Dbkeys.phone]);
          // firestoreInstance
          //     .collection(DbPaths.companies)
          //     .doc(_companyId)
          //     .collection(DbPaths.orders)
          //     .doc(docs.docs[i].get(Dbkeys.orderid))
          //     .collection(DbPaths.orderdetails)
          //     .get()
          //     .then((docs) async {
          //   print("IN FOR");
          //   // print(docs.docs[0].metadata.toString());
          //   print(docs.docs.length.toString());
          // });
        }
      }

      // print("doc length" + docs.docs.length.toString());
      // // print(docs.docs[0].data().containsKey(''));
      // print(docs.docs[0].id);
      // print("model length" + ordermodel.length.toString());
      // print(ordermodel);
      // print(ordermodel[0].numberofproducts);
    });

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: email)
        .where(Dbkeys.shopid, isEqualTo: shopID)
        .get()
        .then((docs) async {
      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid) &&
            docs.docs[i]['status'] != 3) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
          );
          allmodel.add(userModel);
        }
      }
    });

    pendingOrdermodelforSpecificRetailer = pendingmodel;
    inprocessOrdermodelforSpecificRetailer = inprocessmodel;
    completedOrdermodelforSpecificRetailer = completedmodel;
    allOrdermodelforSpecificRetailer = allmodel;
    isDataLoaded = true;
    notifyListeners();
  }

  getOrdersDataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _companyId = pref.getString(Dbkeys.company)!;
    String _email = pref.getString(Dbkeys.email)!;
    // print("log.d");
    // print(_companyId);

    var firestoreInstance = await FirebaseFirestore.instance;
    List<orderModel> pendingmodel = [];
    List<orderModel> inprocessmodel = [];
    List<orderModel> completedmodel = [];

    /*
    PENDING ORDERS
    */

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: _email)
        .where(Dbkeys.status, isEqualTo: 0)
        .get()
        .then((docs) async {
      //  ordermodel.clear();

      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
            // orderdetailModel: []
          );
          pendingmodel.add(userModel);
          // print(docs.docs[i][Dbkeys.phone]);
          // firestoreInstance
          //     .collection(DbPaths.companies)
          //     .doc(_companyId)
          //     .collection(DbPaths.orders)
          //     .doc(docs.docs[i].get(Dbkeys.orderid))
          //     .collection(DbPaths.orderdetails)
          //     .get()
          //     .then((docs) async {
          //   print("IN FOR");
          //   // print(docs.docs[0].metadata.toString());
          //   print(docs.docs.length.toString());
          // });
        }
      }

      // print("doc length" + docs.docs.length.toString());
      // // print(docs.docs[0].data().containsKey(''));
      // print(docs.docs[0].id);
      // print("model length" + ordermodel.length.toString());
      // print(ordermodel);
      // print(ordermodel[0].numberofproducts);
    });

    /*
    IN PROCESS ORDERS
    */

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: _email)
        .where(Dbkeys.status, isEqualTo: 1)
        .get()
        .then((docs) async {
      //  ordermodel.clear();

      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
            // orderdetailModel: []
          );
          inprocessmodel.add(userModel);
          // print(docs.docs[i][Dbkeys.phone]);
          // firestoreInstance
          //     .collection(DbPaths.companies)
          //     .doc(_companyId)
          //     .collection(DbPaths.orders)
          //     .doc(docs.docs[i].get(Dbkeys.orderid))
          //     .collection(DbPaths.orderdetails)
          //     .get()
          //     .then((docs) async {
          //   print("IN FOR");
          //   // print(docs.docs[0].metadata.toString());
          //   print(docs.docs.length.toString());
          // });
        }
      }

      // print("doc length" + docs.docs.length.toString());
      // // print(docs.docs[0].data().containsKey(''));
      // print(docs.docs[0].id);
      // print("model length" + ordermodel.length.toString());
      // print(ordermodel);
      // print(ordermodel[0].numberofproducts);
    });

    /*
    COMPLETED ORDERS
    */

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .where(Dbkeys.addedby, isEqualTo: _email)
        .where(Dbkeys.status, isEqualTo: 2)
        .get()
        .then((docs) async {
      //  ordermodel.clear();

      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.orderid)) {
          String? shopname;
          String? shopAddress;
          await firestoreInstance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.shops)
              .where(Dbkeys.id, isEqualTo: docs.docs[i][Dbkeys.shopid])
              .get()
              .then((value) {
            shopname = value.docs[0][Dbkeys.shopName];
            shopAddress = value.docs[0][Dbkeys.address];
            //     print(shopname!+"shop");
          });

          orderModel userModel = orderModel(
            grandtotal: docs.docs[i][Dbkeys.grandtotal],
            // grandtotal: f,
            note: docs.docs[i][Dbkeys.note],
            timestamp: docs.docs[i][Dbkeys.timestamp],
            company: docs.docs[i][Dbkeys.company],
            status: docs.docs[i][Dbkeys.status],
            orderid: docs.docs[i][Dbkeys.orderid],
            numberofproducts: docs.docs[i][Dbkeys.numberofproducts],
            addedby: docs.docs[i][Dbkeys.addedby],
            shopid: docs.docs[i][Dbkeys.shopid],
            shopname: shopname!,
            address: shopAddress!,
            // orderdetailModel: []
          );
          completedmodel.add(userModel);
          // print(docs.docs[i][Dbkeys.phone]);
          // firestoreInstance
          //     .collection(DbPaths.companies)
          //     .doc(_companyId)
          //     .collection(DbPaths.orders)
          //     .doc(docs.docs[i].get(Dbkeys.orderid))
          //     .collection(DbPaths.orderdetails)
          //     .get()
          //     .then((docs) async {
          //   print("IN FOR");
          //   // print(docs.docs[0].metadata.toString());
          //   print(docs.docs.length.toString());
          // });
        }
      }

      // print("doc length" + docs.docs.length.toString());
      // // print(docs.docs[0].data().containsKey(''));
      // print(docs.docs[0].id);
      // print("model length" + ordermodel.length.toString());
      // print(ordermodel);
      // print(ordermodel[0].numberofproducts);
    });

    pendingOrdermodel = pendingmodel;
    inprocessOrdermodel = inprocessmodel;
    completedOrdermodel = completedmodel;
    isDataLoaded = true;
    notifyListeners();
  }

  getSpecificOrderDetails({required String orderId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _companyId = pref.getString(Dbkeys.company)!;
    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .doc(orderId)
        .collection(DbPaths.orderdetails)
        .get()
        .then((value) {
      allOrderDetails = [];
      for (int i = 0; i < value.docs.length; i++) {
        OrderDetailsModel orderdetails = OrderDetailsModel(
            company: value.docs[i]['company'],
            orderId: value.docs[i]['orderid'],
            productName: value.docs[i]['name'],
            productQuantity: value.docs[i]['quantity'],
            productPrice: value.docs[i]['price'],
            prodId: value.docs[i]['prodid'],
            timestamp: value.docs[i]['timestamp'],
            url: value.docs[i]['url'],
            subTotal: value.docs[i]['subTotal']);

        allOrderDetails.add(orderdetails);
      }
    });
  }

  List<orderDetailModel> orderDetailmodel = [];
  bool isOrderDetailDataLoaded = false;

  misOrderDetailDataLoaded(bool val) {
    isOrderDetailDataLoaded = val;
    notifyListeners();
  }

  double orderDetailGrandTotal = 0;

  getOrdersDataDetails(String ID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _companyId = pref.getString(Dbkeys.company)!;
    String _email = pref.getString(Dbkeys.email)!;

    var firestoreInstance = await FirebaseFirestore.instance;

    List<orderDetailModel> list = [];

    await firestoreInstance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .doc(ID)
        .collection(DbPaths.orderdetails)
        .get()
        .then((docs) async {
      // print("doc length");
      // print(docs.docs.length);
      for (int i = 0; i < docs.docs.length; i++) {
        orderDetailModel model = orderDetailModel(
            url: docs.docs[i]['url'],
            company: docs.docs[i][Dbkeys.company],
            productQuantity: docs.docs[i]['quantity'],
            productName: docs.docs[i]['name'],
            orderId: docs.docs[i]['orderid'],
            productPrice: docs.docs[i]['price'],
            prodId: docs.docs[i][Dbkeys.prodid],
            subTotal: docs.docs[i]['subTotal'],
            timestamp: docs.docs[i][Dbkeys.timestamp]);

        list.add(model);
      }
    });
    orderDetailmodel = list;
    // print("length");
    // print(orderDetailmodel.length);
    isOrderDetailDataLoaded = true;
    notifyListeners();
  }
}

class orderModel {
  final String addedby;
  final String company;
  final double grandtotal;
  final String note;
  final int numberofproducts;
  final String orderid;
  final String shopid;
  final int status;
  final int timestamp;
  final String shopname;
  final String address;

  // final List<orderDetailModel> orderdetailModel;

  orderModel({
    required this.addedby,
    required this.company,
    required this.grandtotal,
    required this.note,
    required this.numberofproducts,
    required this.orderid,
    required this.shopid,
    required this.status,
    required this.timestamp,
    required this.shopname,
    required this.address,
    // required this.orderdetailModel
  });

// factory orderModel.fromJson(Map<String, dynamic> jsonData) {
//   return orderModel(
//     addedby: jsonData[Dbkeys.addedby],
//     company: jsonData[Dbkeys.company],
//     grandtotal: jsonData[Dbkeys.grandtotal],
//     note: jsonData[Dbkeys.note],
//     numberofproducts: jsonData[Dbkeys.numberofproducts],
//     orderid: jsonData[Dbkeys.orderid],
//     shopid: jsonData[Dbkeys.shopid],
//     status: jsonData[Dbkeys.status],
//     timestamp: jsonData[Dbkeys.timestamp],
//     name: '',
//     // orderdetailModel: jsonData["orderdetailModel"],
//   );
// }

// static Map<String, dynamic> toMap(orderModel model) => {
//       Dbkeys.addedby: model.addedby,
//       Dbkeys.company: model.company,
//       Dbkeys.grandtotal: model.grandtotal,
//       Dbkeys.note: model.note,
//       Dbkeys.numberofproducts: model.numberofproducts,
//       Dbkeys.orderid: model.orderid,
//       Dbkeys.shopid: model.shopid,
//       Dbkeys.status: model.status,
//       Dbkeys.timestamp: model.timestamp,
//       // 'orderdetailModel': model.orderdetailModel,
//     };
//
// static String encode(List<orderModel> contacts) => json.encode(
//       contacts
//           .map<Map<String, dynamic>>((contact) => orderModel.toMap(contact))
//           .toList(),
//     );
//
// static List<orderModel> decode(String contacts) =>
//     (json.decode(contacts) as List<dynamic>)
//         .map<orderModel>((item) => orderModel.fromJson(item))
//         .toList();
}

class orderDetailModel {
  String productName;
  String orderId;
  String company;
  double productPrice;
  String prodId;
  int productQuantity;
  double subTotal;
  int timestamp;
  String? url;

  orderDetailModel(
      {required this.company,
      required this.orderId,
      required this.productName,
      required this.productQuantity,
      required this.productPrice,
      required this.prodId,
      required this.timestamp,
      required this.subTotal,
      this.url});

  factory orderDetailModel.fromJson(Map<String, dynamic> jsonData) {
    return orderDetailModel(
        prodId: jsonData['propid'],
        productPrice: jsonData['price'],
        productQuantity: jsonData['quantity'],
        subTotal: jsonData['subTotal'],
        company: jsonData[Dbkeys.company],
        timestamp: jsonData[Dbkeys.timestamp],
        orderId: jsonData['orderid'],
        productName: jsonData['name'],
        url: jsonData['url']);
  }

  static Map<String, dynamic> toMap(orderDetailModel model) => {
        'propid': model.prodId,
        'price': model.productPrice,
        'quantity': model.productQuantity,
        'subTotal': model.subTotal,
        Dbkeys.company: model.company,
        Dbkeys.timestamp: model.timestamp,
        'orderid': model.orderId,
        'name': model.productName,
        'url': model.url,
      };

  static String encode(List<orderDetailModel> contacts) => json.encode(
        contacts
            .map<Map<String, dynamic>>(
                (contact) => orderDetailModel.toMap(contact))
            .toList(),
      );

  static List<orderDetailModel> decode(String contacts) =>
      (json.decode(contacts) as List<dynamic>)
          .map<orderDetailModel>((item) => orderDetailModel.fromJson(item))
          .toList();
}
