import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

final greyLight100 = Colors.grey.shade100;
final greyLight200 = Colors.grey.shade200;

bool isEmailValidae(String email) {
  bool isMatch = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
  return isMatch;
}

bool isValidPassword(String password) {
  return password.length == 6 || password.length > 6 ? true : false;
}

snackBar(String text, GlobalKey<ScaffoldState> _scaffoldKey) {
  final snackBar = SnackBar(
    content: Text('$text'),
    duration: Duration(seconds: 1),
    // action: SnackBarAction(
    //   label: "Close",
    //   onPressed: () {
    //     // Some code to undo the change.
    //   },
    // ),
  );
  _scaffoldKey.currentState!.showSnackBar(snackBar);
}

mShowNotification(
    {required String heading,
    required BuildContext context,
    Color? backgroundColor,
    required String message}) {
  Flushbar(
    title: heading,
    message: message,
    duration: Duration(milliseconds: 1500),
    backgroundColor: primaryColor,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: EdgeInsets.all(8),
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(8),
    icon: Icon(
      Icons.done_all,
      size: 28.0,
      color: Colors.white,
    ),
    leftBarIndicatorColor: Theme.of(context).hintColor,
  )..show(context);
}

mShowNotificationError(
    {required String heading,
    required BuildContext context,
    Color? backgroundColor,
    required String message}) {
  Flushbar(
    title: heading,
    message: message,
    duration: Duration(milliseconds: 1500),
    backgroundColor: Colors.red,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: EdgeInsets.all(8),
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(8),
    icon: Icon(
      Icons.close,
      size: 28.0,
      color: Colors.white,
    ),
    leftBarIndicatorColor: Theme.of(context).hintColor,
  )..show(context);
}
