// import 'package:e_assasa/Provider/modulesAndReportsProvider.dart';
// import 'package:e_assasa/Provider/reportsGridViewProvider.dart';
// import 'package:e_assasa/Routes/routes.dart' as Router;
// import 'package:e_assasa/Utils/DbKeys.dart';
// import 'package:e_assasa/Utils/appConstants.dart';
import 'package:erp_aspire/Configs/Dbkeys.dart';
import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:erp_aspire/Utils/DbKeys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../constants.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            // width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // height: 150,
                  width: 250,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        logo,
                        fit: BoxFit.cover,
                      )),
                ),
                // Text(
                //   " Sales ",
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 22,
                //       color: new Color(0XFF242323)),
                // ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: const Align(
              alignment: FractionalOffset.center,
              child: SizedBox(
                height: 5,
                width: 200,
                child: LinearProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setInitial(context);
    });
  }

  // late reportsGridViewProvider provider;
  // late modulesAndReportsProvider reportsProvider;

  setInitial(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(Dbkeys.email)) {
      if (prefs.getBool(isUserLoggedInLocal)!) {
        Future.delayed(Duration(milliseconds: 800), () {
          final _controller = SidebarXController(selectedIndex: 0);
          Navigator.pushReplacementNamed(context, Router.homepage,
              arguments: _controller);
        });
      } else {
        Future.delayed(Duration(milliseconds: 800), () {
          Navigator.pushReplacementNamed(context, Router.login);
        });
      }
    } else {
      // pro.mLoginApi();
      Future.delayed(Duration(milliseconds: 800), () {
        Navigator.pushReplacementNamed(context, Router.login);
      });
    }
  }
}
