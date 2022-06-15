import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/Configs/Dbkeys.dart';
import 'package:erp_aspire/Configs/Dbpaths.dart';
import 'package:erp_aspire/shared_prefrences/shared_prefrence_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';

class addRetailerProvider with ChangeNotifier {
  // File? shopImage;
  Uint8List webImage = Uint8List(10);
  PickedFile? shopImage;
  LatLng? latlng;
  Address? address;
  TextEditingController addressController = TextEditingController();

  PickedFile get getImage {
    return shopImage!;
  }

  bool get isImageAvail {
    return _isImageSet;
  }

  bool _isImageSet = false;

  void setShopImage(
      {required PickedFile image, required Uint8List webImage}) async {
    shopImage = image;
    this.webImage = webImage;
    _isImageSet = true;
    notifyListeners();
  }

  final List<ShopsTypeModel> shopsType = [];
  bool _isShopsTypesAvail = false;
  String? selecteItemType;
  String? selecteItemId;

  bool get isShopsTypesAvail {
    return _isShopsTypesAvail;
  }

  getDropDownSelectedItem(String id, String type) {
    selecteItemId = id;
    selecteItemType = type;
    notifyListeners();
  }

  getShopsTypesData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _companyId = pref.getString(Dbkeys.company)!;
    // print("log.d");
    // print(_companyId);

    await FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(_companyId)
        .collection(DbPaths.shopsType)
        .get()
        .then((docs) async {
      // print("log.d");
      // print(docs.docs.length);

      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          if (docs.docs[i].data().containsKey(Dbkeys.id)) {
            ShopsTypeModel userModel = ShopsTypeModel(
                id: docs.docs[i][Dbkeys.id], type: docs.docs[i]['type']);
            shopsType.add(userModel);
            // print(docs.docs[i][Dbkeys.phone]);
          }
        }
        // print(shopsType.length);
        selecteItemType = shopsType[0].type;
        selecteItemId = shopsType[0].id;
      }
      _isShopsTypesAvail = true;
      notifyListeners();
    });
  }

  bool dataUploading = false;

  // bool get isShopsDataUploading {
  //   return _dataUploading;
  // }

  ismShopsDataUploading(bool val) {
    dataUploading = val;
    notifyListeners();
  }

  postUploadShopData({
    required String shopName,
    required String ownerName,
    required String cnic,
    required String phone,
    required String address,
    required double lat,
    required double long,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String _companyId = pref.getString(Dbkeys.company)!;
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    log(_companyId.toString());

    String? _email =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();
    log(_email.toString());
    // String _email = pref.getString(Dbkeys.email)!;
    int _uploadTimestamp = DateTime.now().millisecondsSinceEpoch;

    String _id = _companyId! + "-" + '$_uploadTimestamp';
    String uploadedPhotoUrl;

    Reference _reference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(shopImage!.path)}');
    await _reference
        .putData(
      await shopImage!.readAsBytes(),
      SettableMetadata(contentType: 'image/png'),
    )
        .whenComplete(() async {
      await _reference.getDownloadURL().then((value) async {
        uploadedPhotoUrl = value;

        List<String> assignedTo = [_email!];
        log(_email.toString());
        await FirebaseFirestore.instance
            .collection(DbPaths.companies)
            .doc(_companyId)
            .collection(DbPaths.shops)
            .doc(_id)
            .set({
          Dbkeys.id: _id,
          Dbkeys.url: uploadedPhotoUrl,
          Dbkeys.shopName: shopName,
          Dbkeys.ownerName: ownerName,
          Dbkeys.cnic: cnic,
          Dbkeys.phone: phone,
          Dbkeys.address: address,
          Dbkeys.type: "selecteItemType",
          Dbkeys.typeId: "selecteItemId",
          Dbkeys.addedby: _email,
          Dbkeys.timestamp: _uploadTimestamp,
          Dbkeys.approved: false,
          Dbkeys.latlong: GeoPoint(lat, long),
          Dbkeys.assignedto: assignedTo,
          Dbkeys.company: _companyId,
        }, SetOptions(merge: true));
      });
    });

    ismShopsDataUploading(false);
  }

  bool useCurrentLocation = true;

  usemCurrentLocation(bool currentLocation) {
    useCurrentLocation = currentLocation;
    notifyListeners();
  }

  static final addRetailerProvider _instance = addRetailerProvider._internal();

  factory addRetailerProvider() {
    return _instance;
  }

  addRetailerProvider._internal() {
    mGetLocationPermission().then((value) {
      mSetCurrentLocation().then((value) {
        // reverseGeocoding(
        //   latitude: value.latitude,
        //   longitude: value.longitude,
        // );
      });
    });
  }

  Future<void> mGetLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Please allow permission");
      }
    }
  }

  Future<LatLng> mSetCurrentLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition();
    latlng = LatLng(position.latitude, position.longitude);
    print("LOG_D_CURRENTLOCATION ===========");
    return latlng!;
  }

  Future<Address> reverseGeocoding() async {
    GeoCode geoCode = GeoCode();
    address = await geoCode.reverseGeocoding(
        latitude: latlng!.latitude, longitude: latlng!.longitude);
    if (address == null) {
    } else {
      addressController = TextEditingController(
          text:
              "${address!.streetNumber ?? ""} ${address!.streetAddress ?? ""} ${address!.city ?? ""} ${address!.countryName ?? ""}");
    }
    notifyListeners();
    return address!;
  }

  void mUpdateShopLocation(LatLng latlng) async {
    this.latlng = latlng;
    print("LOG_D_CURRENTLOCATION ${this.latlng}");
    notifyListeners();
  }

/*
  postLoc() async {
    // _dataUploading = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String _companyId = pref.getString(Dbkeys.company)!;
    String _email = pref.getString(Dbkeys.email)!;
    int _uploadTimestamp = DateTime.now().millisecondsSinceEpoch;
    String _id = _companyId + "-" + '$_uploadTimestamp';


    await FirebaseFirestore.instance
        .collection("check")
        .doc(_companyId)
        .collection(DbPaths.shops)
        .doc(_id)
        .set({
      Dbkeys.id: _id,
      Dbkeys.company: _companyId,
    }, SetOptions(merge: true));
  }

   onStart() {
    WidgetsFlutterBinding.ensureInitialized();
    final service = FlutterBackgroundService();
    service.onDataReceived.listen((event) {
      if (event!["action"] == "setAsForeground") {
        service.setForegroundMode(true);
        return;
      }

      if (event["action"] == "setAsBackground") {
        service.setForegroundMode(false);
      }

      if (event["action"] == "stopService") {
        service.stopBackgroundService();
      }
    });

    // bring to foreground
    service.setForegroundMode(true);
    Timer.periodic(Duration(seconds: 8), (timer) async {
      if (!(await service.isServiceRunning())) timer.cancel();
      service.setNotificationInfo(
        title: "My App Service",
        content: "Updated at ${DateTime.now()}",
      );

      // service.sendData(
      //   {"current_date": DateTime.now().toIso8601String()},
      // );

      await postLoc();
      // debugPrint();
      // Utils.toast("UPDATE SERVICE${DateTime.now()}}");

    });
  }*/

}

class ShopsTypeModel {
  final String id;
  final String? type;

  ShopsTypeModel({
    required this.id,
    this.type,
  });

  factory ShopsTypeModel.fromJson(Map<String, dynamic> jsonData) {
    return ShopsTypeModel(
      id: jsonData['id'],
      type: jsonData['type'],
    );
  }

  static Map<String, dynamic> toMap(ShopsTypeModel model) => {
        'id': model.id,
        'type': model.type,
      };

  static String encode(List<ShopsTypeModel> contacts) => json.encode(
        contacts
            .map<Map<String, dynamic>>(
                (contact) => ShopsTypeModel.toMap(contact))
            .toList(),
      );

  static List<ShopsTypeModel> decode(String contacts) =>
      (json.decode(contacts) as List<dynamic>)
          .map<ShopsTypeModel>((item) => ShopsTypeModel.fromJson(item))
          .toList();
}
