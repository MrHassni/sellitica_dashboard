// import 'package:e_assasa/Provider/modulesAndReportsProvider.dart';
// import 'package:e_assasa/Provider/reportsGridViewProvider.dart';
// import 'package:e_assasa/Routes/routes.dart' as Router;
// import 'package:e_assasa/Utils/DbKeys.dart';
// import 'package:e_assasa/Utils/appConstants.dart';
import 'package:erp_aspire/Configs/Dbkeys.dart';
import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:erp_aspire/Utils/DbKeys.dart';
import 'package:erp_aspire/provider/company_provider.dart';
import 'package:erp_aspire/screens/add_company.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../Provider/money_provider.dart';
import '../../constants.dart';
import '../../provider/homeProvider.dart';
import '../../provider/shopsProvider.dart';

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
          SizedBox(
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
          SizedBox(
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setInitial(context);
    });
  }

  // late reportsGridViewProvider provider;
  // late modulesAndReportsProvider reportsProvider;

  setInitial(BuildContext context) async {
    Provider.of<ShopsProvider>(context, listen: false).getShopsDataList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(isUserLoggedInLocal) != null &&
        prefs.getBool(isUserLoggedInLocal)! == true &&
        prefs.containsKey(Dbkeys.email)) {
      Provider.of<CompanyProvider>(context, listen: false)
          .getMyCompany()
          .then((_) {
        if (Provider.of<CompanyProvider>(context, listen: false)
                    .myCompanyData!
                    .companyName !=
                '' ||
            Provider.of<CompanyProvider>(context, listen: false)
                    .myCompanyData!
                    .companyId !=
                '' ||
            Provider.of<CompanyProvider>(context, listen: false)
                    .myCompanyData!
                    .companyImgUrl !=
                '') {
          Provider.of<MoneyProvider>(context, listen: false)
              .getTransactions()
              .then((_) {
            Future.delayed(const Duration(milliseconds: 800), () {
              final _controller = SidebarXController(selectedIndex: 0);

              Provider.of<homepage_provider>(context, listen: false)
                  .getOrdersDataList()
                  .then((_) {
                Navigator.pushReplacementNamed(context, Router.homepage,
                    arguments: _controller);
              });
            });
          });
        } else {
          Provider.of<MoneyProvider>(context, listen: false)
              .getTransactions()
              .then((_) {
            Future.delayed(const Duration(milliseconds: 800), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddCompany()));
            });
          });
        }
      });
    } else {
      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.pushReplacementNamed(context, Router.login);
      });
    }
  }
}
