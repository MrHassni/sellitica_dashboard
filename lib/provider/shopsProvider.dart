import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/models/attendance_model.dart';
import 'package:erp_aspire/models/users_Model.dart';
import 'package:erp_aspire/shared_prefrences/shared_prefrence_functions.dart';
import 'package:flutter/cupertino.dart';

import '../Configs/Dbkeys.dart';
import '../Configs/Dbpaths.dart';
import '../screens/products_cloud_search.dart';

class ShopsProvider extends ChangeNotifier {
  List<ShopsProfile> allShops = [];
  List<ShopsProfile> allShopsListOfSpecificUser = [];
  List<ShopsProfile> searchShopsListOfSpecificUser = [];
  List<AttendanceModel> allAttendance = [];
  List<AttendanceModel> allAttendanceOfSpecificUser = [];
  List<users_Model> assignedUserShops = [];

  ShopsProfile? selectedShop;

  deleteShop(id) async {
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.shops)
        .doc(id)
        .delete()
        .then((value) {
      getShopsDataList();
    });
    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.orders)
        .get()
        .then((val) async {
      for (int i = 0; i < val.docs.length; i++) {
        if (val.docs[i]['shopid'] == id) {
          await FirebaseFirestore.instance
              .collection(DbPaths.companies)
              .doc(_companyId)
              .collection(DbPaths.orders)
              .doc(val.docs[i]['orderid'])
              .collection(DbPaths.orderdetails)
              .get()
              .then((v) {
            for (int ind = 0; ind < v.docs.length; ind++) {
              FirebaseFirestore.instance
                  .collection(DbPaths.companies)
                  .doc(_companyId)
                  .collection(DbPaths.orders)
                  .doc(val.docs[i]['orderid'])
                  .collection(DbPaths.orderdetails)
                  .doc(v.docs[ind]['prodid'])
                  .delete()
                  .then((_) {
                FirebaseFirestore.instance
                    .collection(DbPaths.companies)
                    .doc(_companyId)
                    .collection(DbPaths.orders)
                    .doc(val.docs[i]['orderid'])
                    .delete();
              });
            }
          });
        }
      }
    });
  }

  getSpecificUserData({required String userEmail}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get()
        .then((value) {
      log(value.data().toString());
      users_Model user = users_Model(
          email: value['email'],
          companyId: value['company'],
          addedBy: value['addedBy'],
          aboutMe: value['aboutMe'],
          accountstatus: value['accountstatus'],
          actionmessage: value['actionmessage'],
          authenticationType: value['authenticationType'],
          currentDeviceID: value['currentDeviceID'],
          name: value['name'],
          deviceDetails: value['deviceDetails'],
          id: value['id'],
          joinedOn: value['joinedOn'],
          lastLogin: value['lastLogin'],
          notificationTokens: value['notificationTokens'],
          photoUrl: value['photoUrl'],
          targetorders: value['targetorders'],
          targetshops: value['targetshops']);
      assignedUserShops.add(user);
    });
  }

  updateTargetedShops({required String shopId, required bool targeted}) async {
    int _currentDate = DateTime.now().millisecondsSinceEpoch;
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.shops)
        .doc(shopId)
        .update({'targetUpdateTime': _currentDate, 'targeted': targeted});
  }

  getShopsDataList() async {
    final List<ShopsProfile> shopsData = [];
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.shops)
        // .where(Dbkeys.assignedto, arrayContains: email)
        .get()
        .then((docs) async {
      for (int i = 0; i < docs.docs.length; i++) {
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
            company: docs.docs[i][Dbkeys.company],
            targeted: docs.docs[i]['targeted'],
            targetUpdateTime: docs.docs[i]['targetUpdateTime'],
            lastVisit: docs.docs[i]['lastVisit']);
        shopsData.add(userModel);
        // }
        allShops = (shopsData);
      }

      selectedShop = allShops[0];

      notifyListeners();
    });
  }

  getShopsDataListOfSpecificUser({required String email}) async {
    final List<ShopsProfile> _shopsData = [];
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.shops)
        .where(Dbkeys.assignedto, arrayContains: email)
        .get()
        .then((docs) async {
      for (int i = 0; i < docs.docs.length; i++) {
        ShopsProfile _userModel = ShopsProfile(
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
            company: docs.docs[i][Dbkeys.company],
            targeted: docs.docs[i]['targeted'],
            targetUpdateTime: docs.docs[i]['targetUpdateTime'],
            lastVisit: docs.docs[i]['lastVisit']);
        _shopsData.add(_userModel);
        allShopsListOfSpecificUser = (_shopsData);
      }
      selectedShop = allShopsListOfSpecificUser[0];
    });
    notifyListeners();
  }

  searchShopsDataListOfSpecificUser(
      {required String email, required String search}) async {
    final List<ShopsProfile> _searchShopsData = [];
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.shops)
        .where(Dbkeys.assignedto, arrayContains: email)
        .where('shopName', isGreaterThanOrEqualTo: upperLetter(search))
        .where('shopName', isLessThan: upperLetter(search) + 'z')
        .get()
        .then((docs) async {
      for (int i = 0; i < docs.docs.length; i++) {
        ShopsProfile _userModel = ShopsProfile(
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
            company: docs.docs[i][Dbkeys.company],
            targeted: docs.docs[i]['targeted'],
            targetUpdateTime: docs.docs[i]['targetUpdateTime'],
            lastVisit: docs.docs[i]['lastVisit']);
        _searchShopsData.add(_userModel);
        searchShopsListOfSpecificUser = (_searchShopsData);
      }
      selectedShop = searchShopsListOfSpecificUser[0];
    });
    notifyListeners();
  }

  getAttendanceOfSpecificUser({required String userEmail}) async {
    allAttendanceOfSpecificUser.clear();
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    int _currentTime = DateTime.now().millisecondsSinceEpoch;

    // getShopsDataListOfSpecificUser(email: userEmail);
    final List<AttendanceModel> attendanceData = [];
    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection('Attendances')
        .orderBy('timeStamp')
        .get()
        .then((docs) async {
      for (int i = 0; i < docs.docs.length; i++) {
        log(docs.docs[i].data().toString());
        if (_currentTime - docs.docs[i]['timeStamp'] <
                // 86400000
                604800000 &&
            userEmail == docs.docs[i]['email']) {
          AttendanceModel attendanceModel = AttendanceModel(
              email: docs.docs[i]['email'],
              timeStamp: docs.docs[i]['timeStamp'],
              location: docs.docs[i][Dbkeys.latlong],
              shopName: docs.docs[i]['shopName'],
              shopOwner: docs.docs[i]['shopOwner'],
              shopId: docs.docs[i]['shopId']);
          attendanceData.add(attendanceModel);
        }
      }
    });

    attendanceData.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
    allAttendanceOfSpecificUser = (attendanceData.reversed).toList();
    // log(allAttendanceOfSpecificUser.length.toString());
    notifyListeners();
  }

  getShopAttendance() async {
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection('Attendances')
        .orderBy('timeStamp')
        .get()
        .then((docs) async {
      final List<AttendanceModel> attendanceData = [];
      for (int i = 0; i < docs.docs.length; i++) {
        AttendanceModel attendanceModel = AttendanceModel(
            email: docs.docs[i]['email'],
            timeStamp: docs.docs[i]['timeStamp'],
            location: docs.docs[i][Dbkeys.latlong],
            shopName: docs.docs[i]['shopName'],
            shopOwner: docs.docs[i]['shopOwner'],
            shopId: docs.docs[i]['shopId']);
        attendanceData.add(attendanceModel);
        allAttendance = (attendanceData);
      }

      notifyListeners();
    });
  }

  // List<ShopsProfile> get shops => allShops;
  List<AttendanceModel> get attendance => allAttendance;

  ShopsProfile? _shopProfileData;
  bool _isShopProfileDataloaded = false;

  shopProfile(String? shopId) async {
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.shops)
        .doc(shopId)
        .get();

    _shopProfileData =
        ShopsProfile.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    _isShopProfileDataloaded = true;
    notifyListeners();
  }

  mUpdateSelectedShop(ShopsProfile shop) {
    selectedShop = shop;
    notifyListeners();
  }

  static final ShopsProvider _instance = ShopsProvider._internal();

  factory ShopsProvider() {
    return _instance;
  }

  ShopsProvider._internal() {
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
  final String? type;
  final String? typeId;
  final String addedby;
  final int timestamp;
  final bool approved;
  final GeoPoint latlong;
  final List assignedto;
  final String company;
  bool? targeted;
  final int lastVisit;
  final int? targetUpdateTime;

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
      required this.company,
      this.targeted,
      required this.lastVisit,
      this.targetUpdateTime});

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
        targeted: jsonData['targeted'],
        targetUpdateTime: jsonData['targetUpdateTime'],
        lastVisit: jsonData['lastVisit']);
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
        'targetUpdateTime': model.targetUpdateTime,
        'targeted': model.targeted,
        'lastVisit': model.lastVisit
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
