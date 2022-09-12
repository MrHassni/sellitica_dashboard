import 'package:erp_aspire/Configs/Dbkeys.dart';

class OrderDetailsModel {
  String productName;
  String orderId;
  String company;
  double productPrice;
  String prodId;
  double productQuantity;
  double subTotal;
  int timestamp;
  String? url;

  OrderDetailsModel(
      {required this.company,
      required this.orderId,
      required this.productName,
      required this.productQuantity,
      required this.productPrice,
      required this.prodId,
      required this.timestamp,
      required this.subTotal,
      this.url});

  factory OrderDetailsModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderDetailsModel(
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
}
