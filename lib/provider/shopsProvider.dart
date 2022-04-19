import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Configs/Dbkeys.dart';
import '../Configs/Dbpaths.dart';

class shopsProvider extends ChangeNotifier {
  List<ShopsProfile> allShops = [];

  ShopsProfile? selectedShop;

  getShopsDataList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? email = await pref.getString(Dbkeys.email);
    // print("log.d");
    String _companyId = pref.getString(Dbkeys.company)!;
    // print(_companyId);

    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.shops)
        // .where(Dbkeys.assignedto, arrayContains: email)
        .get()
        .then((docs) async {
      // allShops.clear();
      // filteredShops.clear();
      final List<ShopsProfile> shopsData = [];
      for (int i = 0; i < docs.docs.length; i++) {
        if (docs.docs[i].data().containsKey(Dbkeys.id)) {
          ShopsProfile userModel = ShopsProfile(
              id: docs.docs[i][Dbkeys.id],
              url: docs.docs[i][Dbkeys.url],
              shopName: docs.docs[i][Dbkeys.shopName],
              ownerName: docs.docs[i][Dbkeys.ownerName],
              cnic: docs.docs[i][Dbkeys.cnic],
              phone: docs.docs[i][Dbkeys.phone],
              address: docs.docs[i][Dbkeys.address],
              type: docs.docs[i][Dbkeys.type],
              typeId: docs.docs[i][Dbkeys.typeId],
              addedby: docs.docs[i][Dbkeys.addedby],
              timestamp: docs.docs[i][Dbkeys.timestamp],
              approved: docs.docs[i][Dbkeys.approved],
              latlong: docs.docs[i][Dbkeys.latlong],
              assignedto: docs.docs[i][Dbkeys.assignedto],
              company: docs.docs[i][Dbkeys.company]);
          shopsData.add(userModel);
        }
        allShops = (shopsData);
      }

      selectedShop = allShops[0];

      notifyListeners();
    });
  }

  mUpdateSelectedShop(ShopsProfile shop) {
    selectedShop = shop;
    notifyListeners();
  }

  static final shopsProvider _instance = shopsProvider._internal();

  factory shopsProvider() {
    return _instance;
  }

  shopsProvider._internal() {
    getShopsDataList();
  }
}

class ShopsProfile {
  final String id;
  final String url;
  final String shopName;
  final String ownerName;
  final String cnic;
  final String phone;
  final String address;
  final String type;
  final String typeId;
  final String addedby;
  final int timestamp;
  final bool approved;
  final GeoPoint latlong;
  final List assignedto;
  final String company;

  ShopsProfile(
      {required this.id,
      required this.url,
      required this.shopName,
      required this.ownerName,
      required this.cnic,
      required this.phone,
      required this.address,
      required this.type,
      required this.typeId,
      required this.addedby,
      required this.timestamp,
      required this.approved,
      required this.latlong,
      required this.assignedto,
      required this.company});

  factory ShopsProfile.fromJson(Map<String, dynamic> jsonData) {
    return ShopsProfile(
      id: jsonData[Dbkeys.id],
      type: jsonData[Dbkeys.type],
      ownerName: jsonData[Dbkeys.ownerName],
      phone: jsonData[Dbkeys.phone],
      approved: jsonData[Dbkeys.approved],
      typeId: jsonData[Dbkeys.typeId],
      addedby: jsonData[Dbkeys.addedby],
      assignedto: jsonData[Dbkeys.assignedto],
      timestamp: jsonData[Dbkeys.timestamp],
      url: jsonData[Dbkeys.url],
      address: jsonData[Dbkeys.address],
      latlong: jsonData[Dbkeys.latlong],
      cnic: jsonData[Dbkeys.cnic],
      company: jsonData[Dbkeys.company],
      shopName: jsonData[Dbkeys.shopName],
    );
  }

  static Map<String, dynamic> toMap(ShopsProfile model) => {
        Dbkeys.id: model.id,
        Dbkeys.type: model.type,
        Dbkeys.ownerName: model.ownerName,
        Dbkeys.phone: model.phone,
        Dbkeys.approved: model.approved,
        Dbkeys.typeId: model.typeId,
        Dbkeys.addedby: model.addedby,
        Dbkeys.assignedto: model.assignedto,
        Dbkeys.timestamp: model.timestamp,
        Dbkeys.url: model.url,
        Dbkeys.address: model.address,
        Dbkeys.latlong: model.latlong,
        Dbkeys.cnic: model.cnic,
        Dbkeys.company: model.company,
        Dbkeys.shopName: model.shopName,
      };

  static String encode(List<ShopsProfile> contacts) => json.encode(
        contacts
            .map<Map<String, dynamic>>((contact) => ShopsProfile.toMap(contact))
            .toList(),
      );

  static List<ShopsProfile> decode(String contacts) =>
      (json.decode(contacts) as List<dynamic>)
          .map<ShopsProfile>((item) => ShopsProfile.fromJson(item))
          .toList();
}
