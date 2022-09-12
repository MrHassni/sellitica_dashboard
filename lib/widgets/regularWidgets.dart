import 'dart:async';

import 'package:erp_aspire/Routes/Router.dart' as router;
import 'package:erp_aspire/provider/company_provider.dart';
import 'package:erp_aspire/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants.dart';
import '../screens/loginscreen/loginscreen.dart';

Dialog addnewDashboardDiaolog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: SizedBox(
      height: 230.0,
      width: 300.0,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel)),
              const SizedBox(
                width: 10,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Timer(const Duration(milliseconds: 100), () {
                      Navigator.pushReplacementNamed(context, router.addshop);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 60,
                            width: 60,
                            child: SvgPicture.asset(
                                "assets/icons/menu_store.svg")),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("New Shop")
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Timer(const Duration(milliseconds: 100), () {
                      Navigator.pushReplacementNamed(context, router.adduser);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 60,
                            width: 60,
                            child: SvgPicture.asset(
                                "assets/icons/menu_profile.svg")),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("New User")
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

InputDecoration inputdecoration({required String label}) {
  return InputDecoration(
    // hintText: "Shop Name",
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2.0,
      ),
    ),
  );
}

SidebarX sidemenu(
  SidebarXController controller,
  BuildContext ctx,
) {
  return SidebarX(
    // controller: _controller,
    theme: SidebarXTheme(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: const TextStyle(color: Colors.black),
      selectedTextStyle: const TextStyle(color: Colors.black),
      itemTextPadding: const EdgeInsets.only(left: 30),
      selectedItemTextPadding: const EdgeInsets.only(left: 30),
      itemDecoration: BoxDecoration(
        border: Border.all(color: canvasColor),
      ),
      selectedItemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: actionColor.withOpacity(0.37),
        ),
        gradient: const LinearGradient(
          colors: [accentCanvasColor, canvasColor],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: 20,
      ),
    ),
    extendedTheme: const SidebarXTheme(
      width: 200,
      decoration: BoxDecoration(
        color: canvasColor,
      ),
      margin: EdgeInsets.only(right: 10),
    ),
    // footerDivider: divider,
    footerBuilder: (context, extended) {
      return ListTile(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Are you sure you want to Sign Out?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await FirebaseAuth.instance.signOut();
                    pref.clear().then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const loginscreen())));
                  },
                  child: const FittedBox(child: Text('Log Out')),
                )
              ],
            ),
          );
        },
        leading: const Icon(
          Icons.exit_to_app_rounded,
          color: Colors.black,
        ),
        title: controller.extended
            ? const Text(
                "Log Out",
              )
            : Container(),
      );
    },
    footerDivider: SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(
          logosvg,
        ),
      ),
    ),
    headerBuilder: (context, extended) {
      return SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Provider.of<CompanyProvider>(context)
                          .myCompanyData!
                          .companyImgUrl ==
                      null
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        Provider.of<CompanyProvider>(context)
                            .myCompanyData!
                            .companyImgUrl!,
                        height: 90,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
              FittedBox(
                child: Text(Provider.of<CompanyProvider>(context)
                    .myCompanyData!
                    .companyName!),
              )
            ],
          ),
        ),
      );
    },
    controller: controller,
    items: const [
      SidebarXItem(icon: Icons.home, label: 'Dashboard'),
      SidebarXItem(icon: Icons.shopping_bag, label: 'Add Shop'),
      SidebarXItem(icon: Icons.person_add, label: 'Add User'),
      SidebarXItem(icon: Icons.add_box_sharp, label: 'Add Products'),
      SidebarXItem(icon: Icons.task, label: 'All Shops'),
      // SidebarXItem(icon: Icons.document_scanner, label: 'Document'),
      // SidebarXItem(icon: Icons.circle_notifications, label: 'Notification'),
      // SidebarXItem(icon: Icons.person, label: 'Profile'),
      // SidebarXItem(icon: Icons.settings, label: 'Settings'),
    ],
  );
}
