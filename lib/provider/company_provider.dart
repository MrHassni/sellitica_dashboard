import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/Configs/Dbpaths.dart';
import 'package:erp_aspire/models/company_model.dart';
import 'package:erp_aspire/models/product_model.dart';
import 'package:erp_aspire/shared_prefrences/shared_prefrence_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sidebarx/sidebarx.dart';

import '../screens/splashscreen/splashScreen.dart';

class CompanyProvider extends ChangeNotifier {
  final companyNameController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  ProductsModel? productsModel;
  Uint8List webImage = Uint8List(10);
  PickedFile? companyImage;

  PickedFile get getImage {
    return companyImage!;
  }

  bool get isImageAvail {
    return _isImageSet;
  }

  bool _isImageSet = false;
  bool dataUploading = false;

  void setCompanyImage(
      {required PickedFile image, required Uint8List webImage}) async {
    companyImage = image;
    this.webImage = webImage;
    _isImageSet = true;
    notifyListeners();
  }

  ismShopsDataUploading(bool val) {
    dataUploading = val;
    notifyListeners();
  }

  CompanyModel? myCompanyData;

  getMyCompany() async {
    String? company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    if (company == null) {
      CompanyModel _company =
          CompanyModel(companyId: '', companyImgUrl: '', companyName: '');
      myCompanyData = _company;
    } else {
      try {
        await FirebaseFirestore.instance
            .collection(DbPaths.companies)
            .doc(company)
            .get()
            .then((value) {
          if (value.exists && value.data() != null) {
            CompanyModel company = CompanyModel(
                companyId: value['companyId'],
                companyImgUrl: value['imgUrl'],
                companyName: value['companyName']);

            myCompanyData = company;
          } else {
            CompanyModel _company =
                CompanyModel(companyId: '', companyImgUrl: '', companyName: '');
            myCompanyData = _company;
          }
        });
      } catch (e) {
        log(e.toString());
      }
    }

    notifyListeners();
  }

  static final CompanyProvider _instance = CompanyProvider._internal();

  factory CompanyProvider() {
    return _instance;
  }

  CompanyProvider._internal() {
    getMyCompany();
  }

  uploadCompanyData(
      {required String companyName, required BuildContext ctx}) async {
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    String uploadedPhotoUrl;

    Reference _reference = FirebaseStorage.instance
        .ref()
        .child('images/${path.basename(companyImage!.path)}');
    await _reference
        .putData(
      await companyImage!.readAsBytes(),
      SettableMetadata(contentType: 'image/png'),
    )
        .whenComplete(() async {
      await _reference.getDownloadURL().then((value) async {
        uploadedPhotoUrl = value;
        await FirebaseFirestore.instance
            .collection(DbPaths.companies)
            .doc(_companyId)
            .set({
          'companyId': _companyId,
          'imgUrl': uploadedPhotoUrl,
          'companyName': companyName,
        }, SetOptions(merge: true));
      });
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      final _controller = SidebarXController(selectedIndex: 0);
      Navigator.push(
          ctx, MaterialPageRoute(builder: (ctx) => const splashScreen()));
      // Navigator.pushReplacementNamed(ctx, '/homepage', arguments: _controller);
    });
    ismShopsDataUploading(false);
    notifyListeners();
  }
}
