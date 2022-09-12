import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/Configs/Dbkeys.dart';
import 'package:erp_aspire/Configs/Dbpaths.dart';
import 'package:erp_aspire/models/product_model.dart';
import 'package:erp_aspire/shared_prefrences/shared_prefrence_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProductsProvider extends ChangeNotifier {
  final productCountController = TextEditingController();
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  ProductsModel? productsModel;
  Uint8List webImage = Uint8List(10);
  PickedFile? productImage;

  PickedFile get getImage {
    return productImage!;
  }

  bool get isImageAvail {
    return _isImageSet;
  }

  bool _isImageSet = false;
  bool dataUploading = false;

  void setProductImage(
      {required PickedFile image, required Uint8List webImage}) async {
    productImage = image;
    this.webImage = webImage;
    _isImageSet = true;
    notifyListeners();
  }

  ismShopsDataUploading(bool val) {
    dataUploading = val;
    notifyListeners();
  }

  Future<void> mGetProductsDetails() async {
    String? email =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();

    if (email == null) {
    } else {
      await FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .doc(email)
          .get()
          .then((value) {
        productsModel = ProductsModel.fromJson(value.data()!);
      });

      // pref.setString(Dbkeys.email, current_user!.email);
      // pref.setString(Dbkeys.company, current_user!.company);
      // SharedPreferenceFunctions.saveUserEmailSharedPreference(
      //     productsModel!.email);
      // SharedPreferenceFunctions.saveCompanyIDSharedPreference(
      //     productsModel!.companyId);
    }
  }

  List<ProductsModel> allProducts = [];
  late ProductsModel specificProductData;

  Future<void> mGetAllProducts() async {
    List<ProductsModel> allProductsData = [];
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // String? company = await pref.getString(Dbkeys.company);
    String? company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    String? currentUserEmail =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();

    log(company.toString() + currentUserEmail.toString());

    if (company == null) {
    } else {
      try {
        await FirebaseFirestore.instance
            .collection(DbPaths.companies)
            .doc(company)
            .collection(DbPaths.products)
            .get()
            .then((value) {
          for (int i = 0; i < value.docs.length; i++) {
            if (value.docs[i].data()[Dbkeys.status] == "delete") {
            } else
            // if (value.docs[i].data()[Dbkeys.addedby] ==
            //   currentUserEmail)
            {
              ProductsModel products = ProductsModel(
                  companyId: value.docs[i]['company'],
                  addedBy: value.docs[i]['addedby'],
                  productDescription: value.docs[i]['description'],
                  productQuantity: value.docs[i]['quantity'],
                  productPrice: value.docs[i]['price'],
                  productName: value.docs[i]['name'],
                  productStatus: value.docs[i][Dbkeys.status],
                  id: value.docs[i][Dbkeys.id],
                  productUploadDate: value.docs[i]['uploadTime'],
                  productLastUpdated: value.docs[i]['lastUpdateTime'],
                  photoUrl: value.docs[i]['url']);
              allProductsData.add(products);
            }
            allProducts = (allProductsData);
          }
        });
      } catch (e) {
        log(e.toString());
      }
    }

    notifyListeners();
  }

  List<ProductsModel> get allAvailableProducts => allProducts;

  getSpecificProducts({required String id}) async {
    String? company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    if (company == null) {
    } else {
      try {
        await FirebaseFirestore.instance
            .collection(DbPaths.companies)
            .doc(company)
            .collection(DbPaths.products)
            .doc(id)
            .get()
            .then((value) {
          ProductsModel products = ProductsModel(
              companyId: value['company'],
              addedBy: value['addedby'],
              productDescription: value['description'],
              productQuantity: value['quantity'],
              productPrice: value['price'],
              productName: value['name'],
              productStatus: value[Dbkeys.status],
              id: value[Dbkeys.id],
              productUploadDate: value['uploadTime'],
              productLastUpdated: value['lastUpdateTime'],
              photoUrl: value['url']);

          specificProductData = products;
        });
      } catch (e) {
        log(e.toString());
      }
    }

    notifyListeners();
  }

  static final ProductsProvider _instance = ProductsProvider._internal();

  factory ProductsProvider() {
    return _instance;
  }

  ProductsProvider._internal() {
    mGetProductsDetails().then((value) {
      mGetAllProducts();
    });
  }

  mDeleteProducts(
    String id,
  ) async {
    String? company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    allProducts.removeWhere((element) => element.id == id);

    FirebaseFirestore.instance
        .collection(DbPaths.companies)
        .doc(company)
        .collection(DbPaths.products)
        .doc(id)
        .delete(
            // {"status": "delete"}
            );

    notifyListeners();
  }

  uploadProductData(
      {required String productName,
      required String productQuantity,
      required String productPrice,
      required String productDescription}) async {
    String? _companyId =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();

    String? _email =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();

    int _uploadTimestamp = DateTime.now().millisecondsSinceEpoch;

    String _id = '$_uploadTimestamp - $_uploadTimestamp';
    String uploadedPhotoUrl;

    Reference _reference = FirebaseStorage.instance
        .ref()
        .child('images/${path.basename(productImage!.path)}');
    await _reference
        .putData(
      await productImage!.readAsBytes(),
      SettableMetadata(contentType: 'image/png'),
    )
        .whenComplete(() async {
      await _reference.getDownloadURL().then((value) async {
        uploadedPhotoUrl = value;

        // List<String> assignedTo = [_email!];
        log(_email.toString());
        await FirebaseFirestore.instance
            .collection(DbPaths.companies)
            .doc(_companyId)
            .collection(DbPaths.products)
            .doc(_id)
            .set({
          Dbkeys.id: _id,
          Dbkeys.url: uploadedPhotoUrl,
          'name': productName,
          'quantity': productQuantity,
          'price': productPrice,
          'description': productDescription,
          Dbkeys.addedby: _email,
          'uploadTime': _uploadTimestamp,
          'lastUpdateTime': _uploadTimestamp,
          Dbkeys.status: 'allowed',
          Dbkeys.company: _companyId,
        }, SetOptions(merge: true));
      });
    });
    ismShopsDataUploading(false);
  }

  // mUploadNewUser(BuildContext context) async {
  //   String? companyID =
  //       await SharedPreferenceFunctions.getCompanyIDSharedPreference();
  //   String? currentUserEmail =
  //       await SharedPreferenceFunctions.getUserEmailSharedPreference();
  //
  //
  //
  //
  //
  //   Provider.of<authenticationProvider>(context, listen: false)
  //       .createUser(productCountController.text, productPriceController.text)
  //       .then((value) async {
  //     ProductsModel product = ProductsModel(
  //         productQuantity: productCountController.text,
  //         // company: current_user!.company,
  //         companyId: companyID!,
  //         addedBy: currentUserEmail!,
  //         productDescription: productDescriptionController.text,
  //         productStatus: "allowed",
  //         // authenticationType: 0,
  //         // bookings: 0,
  //         // currentDeviceID: "",
  //         // deviceDetails: {"dummy": "dummy"},
  //         id: value.product!.uid,
  //         // id: ,
  //         productUploadDate: Timestamp.now().toDate().millisecondsSinceEpoch,
  //         productLastUpdated: Timestamp.now().toDate().millisecondsSinceEpoch,
  //         // notificationTokens: [],
  //         // orders: 1,
  //         photoUrl: "",
  //         productPrice: productPriceController.text,
  //         // remainingshops: 1,
  //         // targetorders: 1,
  //         // targetshops: 1,
  //         // visitedshops: 0,
  //         productName: productNameController.text);
  //
  //     await FirebaseFirestore.instance
  //         .collection(DbPaths.collectionusers)
  //         .doc(productCountController.text)
  //         .set(product.productsModelToMap())
  //         .then((value) {
  //       mShowNotification(
  //           heading: "Success",
  //           context: context,
  //           message: "New user added successfully");
  //       btnController.success();
  //       productCountController.clear();
  //       productPriceController.clear();
  //       productNameController.clear();
  //       mGetAllUsers();
  //       Timer(const Duration(seconds: 1), () {
  //         btnController.reset();
  //       });
  //     }).onError((error, stackTrace) {
  //       btnController.error();
  //       Timer(const Duration(seconds: 1), () {
  //         btnController.reset();
  //       });
  //
  //       mShowNotificationError(
  //           heading: "Error", context: context, message: error.toString());
  //     });
  //   }).onError((error, stackTrace) {
  //     btnController.error();
  //     mShowNotificationError(
  //         heading: "Error", context: context, message: error.toString());
  //     Timer(const Duration(seconds: 1), () {
  //       btnController.reset();
  //     });
  //   });
  // }
}
