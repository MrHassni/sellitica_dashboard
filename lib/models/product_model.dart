import 'package:erp_aspire/Configs/Dbkeys.dart';

class ProductsModel {
  final String? productDescription;
  final String? productQuantity;
  final String? productPrice;
  // final int authenticationType;
  // final int bookings;
  final String? companyId;
  final String? addedBy;
  final String? productName;
  final String? productStatus;
  // final Map<String, dynamic> deviceDetails;
  // final String email;
  final String? id;
  final int? productUploadDate;
  final int? productLastUpdated;
  // final List notificationTokens;
  // final int orders;
  final String? photoUrl;
  // final String name;
  // final dynamic remainingshops;
  // final dynamic targetorders;
  // final dynamic targetshops;
  // final dynamic visitedshops;

  const ProductsModel({
    // required this.email,
    required this.companyId,
    required this.addedBy,
    required this.productDescription,
    required this.productQuantity,
    required this.productPrice,
    // required this.authenticationType,
    // required this.bookings,
    required this.productName,
    required this.productStatus,
    // required this.name,
    // required this.deviceDetails,
    required this.id,
    required this.productUploadDate,
    required this.productLastUpdated,
    // required this.notificationTokens,
    // required this.orders,
    required this.photoUrl,
    // required this.remainingshops,
    // required this.targetorders,
    // required this.targetshops,
    // required this.visitedshops
  });

  factory ProductsModel.fromJson(Map<String, dynamic> parsedJson) {
    return ProductsModel(
      // email: parsedJson[Dbkeys.email],
      // name: parsedJson[Dbkeys.name],
      companyId: parsedJson['company'],
      addedBy: parsedJson['addedby'] ?? '',
      productDescription: parsedJson['description'],
      productQuantity: parsedJson['quantity'],
      productPrice: parsedJson['price'],
      productStatus: parsedJson['status'],
      // authenticationType: parsedJson[Dbkeys.authenticationType],
      // bookings: parsedJson[Dbkeys.bookings],
      productName: parsedJson['name'],
      // deviceDetails: parsedJson[Dbkeys.deviceDetails],
      id: parsedJson[Dbkeys.id],
      productUploadDate: parsedJson['uploadTime'],
      productLastUpdated: parsedJson['lastUpdateTime'],
      // notificationTokens: parsedJson[Dbkeys.notificationTokens],
      // orders: parsedJson[Dbkeys.orders],
      photoUrl: parsedJson['url'],
      // remainingshops: parsedJson[Dbkeys.remainingshops],
      // targetorders: parsedJson[Dbkeys.targetorders],
      // targetshops: parsedJson[Dbkeys.targetshops],
      // visitedshops: parsedJson[Dbkeys.visitedshops],
    );
  }

  Map<String, dynamic> productsModelToMap() {
    return {
      // "email": email,
      // "name": name,
      "company": companyId,
      "addedby": addedBy,
      "description": productDescription,
      "quantity": productQuantity,
      "price": productPrice,
      // "authenticationType": authenticationType,
      // "bookings": bookings,
      "name": productName,
      // "deviceDetails": deviceDetails,
      "id": id,
      "uploadTime": productUploadDate,
      "lastUpdateTime": productLastUpdated,
      // "notificationTokens": notificationTokens,
      // "orders": orders,
      "status": productStatus,
      "url": photoUrl,
      // "remainingshops": remainingshops,
      // "targetorders": targetorders,
      // "targetshops": targetshops,
      // "visitedshops": visitedshops,
    };
  }
}
