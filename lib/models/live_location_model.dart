import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LiveLocationModel {
  final String email;
  final int timeStamp;
  final GeoPoint latLong;

  LiveLocationModel(
      {required this.email, required this.timeStamp, required this.latLong});

  factory LiveLocationModel.fromJson(Map<String, dynamic> jsonData) {
    return LiveLocationModel(
      email: jsonData['email'],
      latLong: jsonData['latLong'],
      timeStamp: jsonData['timeStamp'],
    );
  }

  static Map<String, dynamic> toMap(LiveLocationModel model) => {
        'email': model.email,
        'latLong': model.latLong,
        'timeStamp': model.timeStamp
      };

  static String encode(List<LiveLocationModel> contacts) => json.encode(
        contacts
            .map<Map<String, dynamic>>(
                (contact) => LiveLocationModel.toMap(contact))
            .toList(),
      );

  static List<LiveLocationModel> decode(String contacts) =>
      (json.decode(contacts) as List<dynamic>)
          .map<LiveLocationModel>((item) => LiveLocationModel.fromJson(item))
          .toList();
}
