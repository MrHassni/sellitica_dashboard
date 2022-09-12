import '../Configs/Dbkeys.dart';

class AddMoneyModel {
  String payedBy;
  String payedTo;
  int timestamp;
  double amountPayed;
  String paymentMethod;

  AddMoneyModel({
    required this.payedBy,
    required this.amountPayed,
    required this.payedTo,
    required this.paymentMethod,
    required this.timestamp,
  });

  factory AddMoneyModel.fromJson(Map<String, dynamic> jsonData) {
    return AddMoneyModel(
        payedTo: jsonData['payedTo'],
        payedBy: jsonData['payedBy'],
        paymentMethod: jsonData['method'],
        amountPayed: jsonData['amount'],
        timestamp: jsonData[Dbkeys.timestamp]);
  }
}
