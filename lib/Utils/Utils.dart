import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  // static changeStatusColor(Color color) async {
  //   try {
  //     await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
  //     if (useWhiteForeground(color)) {
  //       FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  //       FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
  //     } else {
  //       FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  //       FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  //     }
  //   } on PlatformException catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  static Widget sales_basicAppba(
      double elevation, String title, Color color, Color textColor) {
    return AppBar(
      elevation: elevation,
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      centerTitle: Platform.isIOS ? true : false,
      backgroundColor: color,
    );
  }

  static Future<bool> checkAndRequestPermission(Permission permission) {
    Completer<bool> completer = new Completer<bool>();
    permission.request().then((status) {
      if (status != PermissionStatus.granted) {
        permission.request().then((_status) {
          bool granted = _status == PermissionStatus.granted;
          completer.complete(granted);
        });
      } else
        completer.complete(true);
    });
    return completer.future;
  }

  static parseDateAndTime(int DateTimes) {
    // int DateTimes = DateTime.now().millisecondsSinceEpoch;

    DateTime date = new DateTime.fromMillisecondsSinceEpoch(DateTimes);
    String dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    return dateFormat;
  }

  static parseDate(int DateTimes) {
    // int DateTimes = DateTime.now().millisecondsSinceEpoch;

    DateTime date = new DateTime.fromMillisecondsSinceEpoch(DateTimes);
    String dateFormat = DateFormat("yyyy-MM-dd").format(date);
    return dateFormat;
  }

  static var phonemaskFormatter = new MaskTextInputFormatter(
      mask: '####-#######', filter: {"#": RegExp(r'[0-9]')});
  static var cnicmaskFormatter = new MaskTextInputFormatter(
      mask: '#####-#######-#', filter: {"#": RegExp(r'[0-9]')});

  static bool isValidCnic(String cnic) {
    return cnic.length == 15 || cnic.length > 15 ? true : false;
  }

  static bool isValidPhone(String phone) {
    return phone.length == 12 || phone.length > 12 ? true : false;
  }
}

Widget customCircleAvatarShop({String? url, double? radius}) {
  // if (url == null || url == '') {
  //   return CircleAvatar(
  //     backgroundColor: Color(0xffE6E6E6),
  //     radius: radius ?? 28,
  //     child: Icon(
  //       Icons.shopping_bag_outlined,
  //       color: Color(0xffCCCCCC),
  //     ),
  //   );
  // } else {
  return SizedBox(
    height: 55,
    width: 55,
    child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        // topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: Image.network(
          url!,
          filterQuality: FilterQuality.low,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        )),
  );

  // return ClipOval(
  //   child: Image.network(
  //     'https://via.placeholder.com/150',
  //     width: 100,
  //     height: 100,
  //     fit: BoxFit.cover,
  //   ),
  // );

  // }
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
