import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/Configs/Dbkeys.dart';
import 'package:erp_aspire/Configs/Dbpaths.dart';
import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/models/live_location_model.dart';
import 'package:erp_aspire/models/users_Model.dart';
import 'package:erp_aspire/shared_prefrences/shared_prefrence_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/products_cloud_search.dart';
import 'authenticationProvider.dart';

class userProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final passwordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  users_Model? current_user;
  bool userAvailable = false;

  isUserAvailable() async {
    String? email =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();

    if (email == null) {
    } else {
      await FirebaseFirestore.instance
          .collection(DbPaths.collectionusers)
          .get()
          .then((val) {
        for (int i = 0; i < val.docs.length; i++) {
          if (email == val.docs[i]['email']) {
            userAvailable = true;
          }
        }
      });
    }
  }

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

      SharedPreferenceFunctions.saveUserEmailSharedPreference(
          current_user!.email);
      SharedPreferenceFunctions.saveCompanyIDSharedPreference(
          current_user!.companyId);
    }
  }

  List<users_Model> allusers = [];
  List<users_Model> searchedUsers = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? allUsersForSearch;

  Future<void> mGetAllUsers() async {
    List<users_Model> allusers = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String? company = await pref.getString(Dbkeys.company);
    String? company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    String? currentUserEmail =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();
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
      // allUsersForSearch = await FirebaseFirestore.instance
      //     .collection(DbPaths.collectionusers)
      //     .where(Dbkeys.company, isEqualTo: company)
      //     .snapshots();
    }

    notifyListeners();
  }

  Future<void> mGetSearchUsers({required String search}) async {
    List<users_Model> searchUsers = [];
    String? company =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    String? currentUserEmail =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();

    await FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .where(Dbkeys.company, isEqualTo: company)
        // .where('name', isEqualTo: search)
        .where('name', isGreaterThanOrEqualTo: upperLetter(search))
        .where('name', isLessThan: upperLetter(search) + 'z')
        // .startAt([search])
        // .endAt([search + '\uf8ff'])
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data().containsKey("status")) {
          if (element.data()["status"] == "delete") {
          } else if (element.data()["addedBy"] == currentUserEmail) {
            searchUsers.add(users_Model.fromJson(element.data()));
          }
        } else if (element.data()["addedBy"] == currentUserEmail) {
          searchUsers.add(users_Model.fromJson(element.data()));
        }
      }
      searchedUsers = searchUsers;
    });
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

  updateOrderTarget({required String email, required int target}) async {
    await FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .doc(email)
        .update({Dbkeys.targetorders: target});
  }

  mDeleteUsers(String id, String email) {
    allusers.removeWhere((element) => element.id == id);

    FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .doc(email)
        .update({"status": "delete"});

    notifyListeners();
  }

  upDateLocation() async {
    log('hjjjjjjjjjj  jj jj jj u uouo  j ju   iou ouj  ju ju   ju ju ');
    GeoPoint location = const GeoPoint(0, 0);
    int time = DateTime.now().millisecondsSinceEpoch;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(emailController.text)
        .collection('LocationTracking')
        .add({
      'email': emailController.text,
      'timeStamp': time,
      'latLong': location,
    }).whenComplete(() async {
      print("Completed");
    }).catchError((e) => print(e));
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
        upDateLocation();
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

  List<LiveLocationModel> liveLocations = [];

  getLiveLocation(email) async {
    int time = DateTime.now().millisecondsSinceEpoch;
    List<LiveLocationModel> allLocations = [];

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .collection('LocationTracking')
          .orderBy('timeStamp', descending: true)
          .limit(50)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          LiveLocationModel model = LiveLocationModel(
              email: value.docs[i]['email'],
              timeStamp: value.docs[i]['timeStamp'],
              latLong: value.docs[i]['latLong']);
          allLocations.add(model);
        }
        liveLocations = allLocations;
      }).catchError((e) {
        log(e.toString() + ' 2');
      });
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  mUploadMyData(BuildContext context) async {
    String? companyID =
        await SharedPreferenceFunctions.getCompanyIDSharedPreference();
    String? currentUserEmail =
        await SharedPreferenceFunctions.getUserEmailSharedPreference();

    users_Model user = users_Model(
        email: currentUserEmail!,
        // company: current_user!.company,
        companyId: companyID!,
        addedBy: 'Admin',
        aboutMe: "",
        accountstatus: "allowed",
        actionmessage: "Welcome",
        authenticationType: 0,
        // bookings: 0,
        currentDeviceID: "",
        deviceDetails: {"dummy": "dummy"},
        id: companyID + '1',
        joinedOn: Timestamp.now().toDate().millisecondsSinceEpoch,
        lastLogin: Timestamp.now().toDate().millisecondsSinceEpoch,
        notificationTokens: [],
        // orders: 1,
        photoUrl: "",
        // remainingshops: 1,
        targetorders: 0,
        targetshops: 0,
        // visitedshops: 0,
        name: fullnameController.text);

    await FirebaseFirestore.instance
        .collection(DbPaths.collectionusers)
        .doc(currentUserEmail)
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
  }
}
