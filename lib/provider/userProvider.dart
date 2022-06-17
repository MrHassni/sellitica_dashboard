import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/Configs/Dbkeys.dart';
import 'package:erp_aspire/Configs/Dbpaths.dart';
import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/models/users_Model.dart';
import 'package:erp_aspire/shared_prefrences/shared_prefrence_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authenticationProvider.dart';

class userProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final passwordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  users_Model? current_user;

  Future<void> mGetUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? email =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();

    if (email == null) {
    } else {
      await FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .doc(email)
          .get()
          .then((value) {
        current_user = users_Model.fromJson(value.data()!);
      });

      // pref.setString(Dbkeys.email, current_user!.email);
      // pref.setString(Dbkeys.company, current_user!.company);
      SharedPreferenceFunctions.saveUserEmailSharedPreference(
          current_user!.email);
      SharedPreferenceFunctions.saveCompanyIDSharedPreference(
          current_user!.companyId);
    }
  }

  List<users_Model> allusers = [];

  Future<void> mGetAllUsers() async {
    List<users_Model> allusers = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String? company = await pref.getString(Dbkeys.company);
    String? company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    String? currentUserEmail =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();
    log('-------------------------------');
    if (company == null) {
    } else {
      await FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .where(Dbkeys.company, isEqualTo: company)
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (element.data().containsKey("status")) {
            if (element.data()["status"] == "delete") {
            } else if (element.data()["addedBy"] == currentUserEmail) {
              allusers.add(users_Model.fromJson(element.data()));
            }
          } else if (element.data()["addedBy"] == currentUserEmail) {
            allusers.add(users_Model.fromJson(element.data()));
          }
        }
        this.allusers = allusers;
      });
    }

    notifyListeners();
  }

  static final userProvider _instance = userProvider._internal();

  factory userProvider() {
    return _instance;
  }

  userProvider._internal() {
    mGetUserDetails().then((value) {
      mGetAllUsers();
    });
  }

  mDeleteUsers(String id, String email) {
    allusers.removeWhere((element) => element.id == id);

    FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .doc(email)
        .update({"status": "delete"});

    notifyListeners();
  }

  mUploadNewUser(BuildContext context) async {
    String? companyID =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    String? currentUserEmail =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();

    Provider.of<authenticationProvider>(context, listen: false)
        .createUser(emailController.text, passwordController.text)
        .then((value) async {
      users_Model user = users_Model(
          email: emailController.text,
          // company: current_user!.company,
          companyId: companyID!,
          addedBy: currentUserEmail!,
          aboutMe: "",
          accountstatus: "allowed",
          actionmessage: "Welcome",
          authenticationType: 0,
          // bookings: 0,
          currentDeviceID: "",
          deviceDetails: {"dummy": "dummy"},
          id: value.user!.uid,
          joinedOn: Timestamp.now().toDate().millisecondsSinceEpoch,
          lastLogin: Timestamp.now().toDate().millisecondsSinceEpoch,
          notificationTokens: [],
          // orders: 1,
          photoUrl: "",
          // remainingshops: 1,
          targetorders: 1,
          targetshops: 1,
          // visitedshops: 0,
          name: fullnameController.text);

      await FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .doc(emailController.text)
          .set(user.users_Model_To_Map())
          .then((value) {
        mShowNotification(
            heading: "Success",
            context: context,
            message: "New user added successfully");
        btnController.success();
        emailController.clear();
        passwordController.clear();
        fullnameController.clear();
        mGetAllUsers();
        Timer(const Duration(seconds: 1), () {
          btnController.reset();
        });
      }).onError((error, stackTrace) {
        btnController.error();
        Timer(const Duration(seconds: 1), () {
          btnController.reset();
        });

        mShowNotificationError(
            heading: "Error", context: context, message: error.toString());
      });
    }).onError((error, stackTrace) {
      btnController.error();
      mShowNotificationError(
          heading: "Error", context: context, message: error.toString());
      Timer(const Duration(seconds: 1), () {
        btnController.reset();
      });
    });
  }
}
