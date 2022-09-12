import 'package:erp_aspire/Configs/Dbkeys.dart';

class orderModel {
  final String addedby;
  final String company;
  final double grandtotal;
  final String? note;
  final int numberofproducts;
  final String? orderid;
  final String shopid;
  int status;
  final int timestamp;
  final String? shopname;

  orderModel({
    required this.addedby,
    required this.company,
    required this.grandtotal,
    this.note,
    required this.numberofproducts,
    this.orderid,
    required this.shopid,
    required this.status,
    required this.timestamp,
    this.shopname,
  });

  factory orderModel.fromJson(Map<String, dynamic> jsonData) {
    return orderModel(
      addedby: jsonData[Dbkeys.addedby],
      company: jsonData[Dbkeys.company],
      grandtotal: jsonData[Dbkeys.grandtotal],
      note: jsonData[Dbkeys.note],
      numberofproducts: jsonData[Dbkeys.numberofproducts],
      orderid: jsonData[Dbkeys.orderid],
      shopid: jsonData[Dbkeys.shopid],
      status: jsonData[Dbkeys.status],
      timestamp: jsonData[Dbkeys.timestamp],
      shopname: jsonData[Dbkeys.name],
    );
  }
}
