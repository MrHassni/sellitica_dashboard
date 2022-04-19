import 'package:erp_aspire/Configs/Dbkeys.dart';

class orderModel {
  String addedby;
  String bankname;
  String chequeno;
  String company;
  String fromaccount;
  double grandtotal;
  String note;
  int numberofproducts;
  String orderid;
  String paymentmethod;
  String receivedamount;
  String shopid;
  int status;
  int timestamp;
  String toaccount;
  String transactionID;
  String shopname;
  String address;

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
    required this.bankname,
    required this.chequeno,
    required this.fromaccount,
    required this.paymentmethod,
    required this.receivedamount,
    required this.toaccount,
    required this.transactionID,
  });

  factory orderModel.fromJson(Map<String, dynamic> jsonData) {
    return orderModel(
      addedby: jsonData[Dbkeys.addedby],
      bankname: jsonData[Dbkeys.bankname],
      chequeno: jsonData[Dbkeys.checkno],
      company: jsonData[Dbkeys.company],
      fromaccount: jsonData[Dbkeys.fromaccount],
      grandtotal: jsonData[Dbkeys.grandtotal],
      note: jsonData[Dbkeys.note],
      numberofproducts: jsonData[Dbkeys.numberofproducts],
      orderid: jsonData[Dbkeys.orderid],
      paymentmethod: jsonData[Dbkeys.paymentmethod],
      receivedamount: jsonData[Dbkeys.receivedamount],
      shopid: jsonData[Dbkeys.shopid],
      status: jsonData[Dbkeys.status],
      timestamp: jsonData[Dbkeys.timestamp],
      toaccount: jsonData[Dbkeys.toaccount],
      transactionID: jsonData[Dbkeys.transactionid],
      shopname: jsonData[Dbkeys.shopName],
      address: jsonData[Dbkeys.address],
    );
  }
}
