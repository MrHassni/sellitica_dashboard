import 'package:erp_aspire/Utils/DbKeys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_prefrences/shared_prefrence_functions.dart';

class authenticationProvider with ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool isUserCreated = false;
  String userRegisterationMessage = "";

  bool isUserLoggedIn = false;
  String userLoginMessage = "";

  Future<UserCredential> createUser(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      isUserCreated = true;
      notifyListeners();
      print(userCredential.user!.uid);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        userRegisterationMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        userRegisterationMessage = "The account already exists for that email.";
      }
      isUserCreated = false;
      notifyListeners();
      throw userRegisterationMessage;
    } catch (e) {
      isUserCreated = false;
      userRegisterationMessage = "Something went wrong";
      notifyListeners();
      print(e);
      throw userRegisterationMessage;
    }
  }

  done() {
    isUserLoggedIn = false;
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // print(userCredential.user!.uid);
      isUserLoggedIn = true;
      SharedPreferenceFunctions.saveUserEmailSharedPreference(email);
      SharedPreferenceFunctions.saveUserLoggedInSharedPreference(true);
      SharedPreferenceFunctions.saveCompanyIDSharedPreference(
          userCredential.user!.uid);
      userLoginMessage = "Welcome.!";
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        userLoginMessage = "No user found for that email..!";
        isUserLoggedIn = false;
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        userLoginMessage = "Wrong password provided for that user..!";
        isUserLoggedIn = false;
        notifyListeners();
      } else {
        userLoginMessage = "Something went wrong..!";
        isUserLoggedIn = false;
        notifyListeners();
      }
    }
  }

  mSaveUserLocal(String useremail, String userpassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(isUserLoggedInLocal, true);
    preferences.setString(email, useremail);
    preferences.setString(password, userpassword);
  }
}
