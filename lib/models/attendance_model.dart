import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String email, shopName, shopOwner, shopId;
  final int timeStamp;
  final GeoPoint location;

  AttendanceModel(
      {required this.email,
      required this.timeStamp,
      required this.location,
      required this.shopName,
      required this.shopOwner,
      required this.shopId});

  factory AttendanceModel.fromJson(Map<String, dynamic> jsonData) {
    return AttendanceModel(
        email: jsonData['email'],
        timeStamp: jsonData['timeStamp'],
        location: jsonData['latlong'],
        shopName: jsonData['shopName'],
        shopOwner: jsonData['shopOwner'],
        shopId: jsonData['shopId']);
  }

  static Map<String, dynamic> toMap(AttendanceModel model) => {
        'email': model.email,
        'timeStamp': model.timeStamp,
        'latlong': model.location,
        'shopName': model.shopName,
        'shopOwner': model.shopOwner,
        'shopId': model.shopId
      };

  static String encode(List<AttendanceModel> contacts) => json.encode(
        contacts
            .map<Map<String, dynamic>>(
                (contact) => AttendanceModel.toMap(contact))
            .toList(),
      );

  static List<AttendanceModel> decode(String contacts) =>
      (json.decode(contacts) as List<dynamic>)
          .map<AttendanceModel>((item) => AttendanceModel.fromJson(item))
          .toList();
}
