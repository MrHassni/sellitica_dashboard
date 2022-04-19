import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/Configs/Dbkeys.dart';
import 'package:erp_aspire/Configs/Dbpaths.dart';
import 'package:erp_aspire/Configs/Enum.dart';
import 'package:erp_aspire/models/orderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage_provider with ChangeNotifier {
  List<orderModel> pendingOrdermodel = [];
  List<orderModel> inprocessOrdermodel = [];
  List<orderModel> completedOrdermodel = [];
  List<orderModel> othersOrdermodel = [];

  List<PlutoRow> pendingOrdersGridList = [];
  List<PlutoRow> inprocessOrdersGridList = [];
  List<PlutoRow> completeOrdersGridList = [];
  List<PlutoRow> othersOrdersGridList = [];

  bool isDataLoaded = false;
  static final homepage_provider _instance = homepage_provider._internal();

  factory homepage_provider() {
    return _instance;
  }

  homepage_provider._internal() {
    getOrdersDataList();
  }

  getOrdersDataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _companyId = pref.getString(Dbkeys.company);

    if (_companyId == null) {
      return;
    } else {
      var firestoreInstance = FirebaseFirestore.instance;
      List<orderModel> pendingmodel = [];

      /*
    PENDING ORDERS
    */

      await firestoreInstance
          .collection(DbPaths.companies)
          .doc(_companyId)
          .collection(DbPaths.orders)
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
                .doc(docs.docs[i][Dbkeys.shopid])
                .get()
                .then((value) {
              shopname = value.data()![Dbkeys.shopName];
              shopAddress = value.data()![Dbkeys.address];
            }).onError((error, stackTrace) {
              print("error1");
              print(error);
            });
            Map<String, dynamic> mapData = docs.docs[i].data();
            mapData.putIfAbsent(Dbkeys.shopName, () => shopname);
            mapData.putIfAbsent(Dbkeys.address, () => shopAddress);
            pendingmodel.add(orderModel.fromJson(mapData));
          }
        }
      }).onError((error, stackTrace) {
        print("error2");
        print(error);
      });

      pendingOrdermodel =
          pendingmodel.where((element) => element.status == 0).toList();
      inprocessOrdermodel =
          pendingmodel.where((element) => element.status == 1).toList();
      completedOrdermodel =
          pendingmodel.where((element) => element.status == 2).toList();
      othersOrdermodel = pendingmodel
          .where((element) => element.status == 3 || element.status == 4)
          .toList();
      isDataLoaded = true;

      print("pendingOrdermodel${pendingOrdermodel.length}");
      print("inprocessOrdermodel${inprocessOrdermodel.length}");
      print("completedOrdermodel${completedOrdermodel.length}");
      print("othersOrdermodel${othersOrdermodel.length}");
    }
    notifyListeners();

    List<PlutoRow> pendingrows = [];
    pendingOrdermodel.forEach((element) {
      var status = '';

      orderType.forEach((key, value) {
        if (value == element.status) {
          status = key;
        }
      });

      pendingrows.add(PlutoRow(
        cells: {
          'qty': PlutoCell(value: element.numberofproducts.toString()),
          'id': PlutoCell(value: element.orderid.toString()),
          'name': PlutoCell(value: element.shopname),
          'addedby': PlutoCell(value: element.addedby),
          'note': PlutoCell(value: element.note),
          'status': PlutoCell(value: status),
          'time': PlutoCell(
              value: DateTime.fromMicrosecondsSinceEpoch(element.timestamp)
                  .toString()),
          'bank': PlutoCell(value: element.bankname),
          'cheque': PlutoCell(value: element.chequeno),
          'from': PlutoCell(value: element.fromaccount),
          'to': PlutoCell(value: element.toaccount),
          'method': PlutoCell(value: element.paymentmethod),
          'receive': PlutoCell(value: element.receivedamount.toString()),
          'transaction': PlutoCell(value: element.transactionID.toString()),
        },
      ));
    });
    pendingOrdersGridList = pendingrows;

    List<PlutoRow> inprocess = [];
    inprocessOrdermodel.forEach((element) {
      var status = '';
      orderType.forEach((key, value) {
        if (value == element.status) {
          status = key;
        }
      });
      inprocess.add(PlutoRow(
        cells: {
          'qty': PlutoCell(value: element.numberofproducts.toString()),
          'id': PlutoCell(value: element.orderid.toString()),
          'name': PlutoCell(value: element.shopname),
          'addedby': PlutoCell(value: element.addedby),
          'note': PlutoCell(value: element.note),
          'status': PlutoCell(value: status),
          'time': PlutoCell(
              value: DateTime.fromMicrosecondsSinceEpoch(element.timestamp)
                  .toString()),
          'bank': PlutoCell(value: element.bankname),
          'cheque': PlutoCell(value: element.chequeno),
          'from': PlutoCell(value: element.fromaccount),
          'to': PlutoCell(value: element.toaccount),
          'method': PlutoCell(value: element.paymentmethod),
          'receive': PlutoCell(value: element.receivedamount.toString()),
          'transaction': PlutoCell(value: element.transactionID.toString()),
        },
      ));
    });
    inprocessOrdersGridList = inprocess;

    List<PlutoRow> complete = [];
    completedOrdermodel.forEach((element) {
      var status = '';
      orderType.forEach((key, value) {
        if (value == element.status) {
          status = key;
        }
      });
      complete.add(PlutoRow(
        cells: {
          'qty': PlutoCell(value: element.numberofproducts.toString()),
          'id': PlutoCell(value: element.orderid.toString()),
          'name': PlutoCell(value: element.shopname),
          'addedby': PlutoCell(value: element.addedby),
          'note': PlutoCell(value: element.note),
          'status': PlutoCell(value: status),
          'time': PlutoCell(
              value: DateTime.fromMicrosecondsSinceEpoch(element.timestamp)
                  .toString()),
          'bank': PlutoCell(value: element.bankname),
          'cheque': PlutoCell(value: element.chequeno),
          'from': PlutoCell(value: element.fromaccount),
          'to': PlutoCell(value: element.toaccount),
          'method': PlutoCell(value: element.paymentmethod),
          'receive': PlutoCell(value: element.receivedamount.toString()),
          'transaction': PlutoCell(value: element.transactionID.toString()),
        },
      ));
    });
    completeOrdersGridList = complete;

    List<PlutoRow> others = [];
    othersOrdermodel.forEach((element) {
      var status = '';
      orderType.forEach((key, value) {
        if (value == element.status) {
          status = key;
        }
      });
      others.add(PlutoRow(
        cells: {
          'qty': PlutoCell(value: element.numberofproducts.toString()),
          'id': PlutoCell(value: element.orderid.toString()),
          'name': PlutoCell(value: element.shopname),
          'addedby': PlutoCell(value: element.addedby),
          'note': PlutoCell(value: element.note),
          'status': PlutoCell(value: status),
          'time': PlutoCell(
              value: DateTime.fromMicrosecondsSinceEpoch(element.timestamp)
                  .toString()),
          'bank': PlutoCell(value: element.bankname),
          'cheque': PlutoCell(value: element.chequeno),
          'from': PlutoCell(value: element.fromaccount),
          'to': PlutoCell(value: element.toaccount),
          'method': PlutoCell(value: element.paymentmethod),
          'receive': PlutoCell(value: element.receivedamount.toString()),
          'transaction': PlutoCell(value: element.transactionID.toString()),
        },
      ));
    });
    othersOrdersGridList = others;

    notifyListeners();
  }

  mUpdateStatus(String orderid, int currentstatus, int updateStatus) async {
    if (currentstatus == 0) {
      int index =
          pendingOrdermodel.indexWhere((element) => element.orderid == orderid);
      orderModel model = pendingOrdermodel[index];
      pendingOrdermodel.removeWhere((element) => element.orderid == orderid);
      pendingOrdersGridList
          .removeWhere((element) => element.cells['id'] == orderid);
      notifyListeners();
      model.status = updateStatus;
      if (updateStatus == 0) {
        pendingOrdermodel.add(model);
      }
      if (updateStatus == 1) {
        inprocessOrdermodel.add(model);
      } else if (updateStatus == 2) {
        completedOrdermodel.add(model);
      } else {
        othersOrdermodel.add(model);
      }
    }

    /////////// iF CURRENT STATUS IS EQUAL TO 1 THEN WE NEED TO UPDATE THE STATUS FOR IN_PROCESS ORDERS

    else if (currentstatus == 1) {
      int index = inprocessOrdermodel
          .indexWhere((element) => element.orderid == orderid);
      orderModel model = inprocessOrdermodel[index];
      inprocessOrdermodel.removeWhere((element) => element.orderid == orderid);
      inprocessOrdersGridList
          .removeWhere((element) => element.cells['id'] == orderid);
      notifyListeners();
      model.status = updateStatus;
      if (updateStatus == 0) {
        pendingOrdermodel.add(model);
      }
      if (updateStatus == 1) {
        inprocessOrdermodel.add(model);
      } else if (updateStatus == 2) {
        completedOrdermodel.add(model);
      } else {
        othersOrdermodel.add(model);
      }
      notifyListeners();
    }

    /////////// iF CURRENT STATUS IS EQUAL TO 2 THEN WE NEED TO UPDATE THE STATUS FOR COMPLETED ORDERS

    else if (currentstatus == 2) {
      int index = completedOrdermodel
          .indexWhere((element) => element.orderid == orderid);
      orderModel model = completedOrdermodel[index];
      completedOrdermodel.removeWhere((element) => element.orderid == orderid);
      completeOrdersGridList
          .removeWhere((element) => element.cells['id'] == orderid);
      notifyListeners();
      model.status = updateStatus;
      if (updateStatus == 0) {
        pendingOrdermodel.add(model);
      }
      if (updateStatus == 1) {
        inprocessOrdermodel.add(model);
      } else if (updateStatus == 2) {
        completedOrdermodel.add(model);
      } else {
        othersOrdermodel.add(model);
      }
      notifyListeners();
    }

    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(orderid.split("-")[0])
        .collection(DbPaths.orders)
        .doc(orderid)
        .update({"status": updateStatus});

    notifyListeners();

    getOrdersDataList();
  }
}
