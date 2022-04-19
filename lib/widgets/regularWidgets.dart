import 'dart:async';

import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:erp_aspire/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sidebarx/sidebarx.dart';

import '../constants.dart';

Dialog addnewDashboardDiaolog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
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
                  icon: Icon(Icons.cancel)),
              SizedBox(
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
                    Timer(Duration(milliseconds: 100), () {
                      Navigator.pushReplacementNamed(context, Router.addshop);
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
                        SizedBox(
                          height: 15,
                        ),
                        Text("New Shop")
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Timer(Duration(milliseconds: 100), () {
                      Navigator.pushReplacementNamed(context, Router.adduser);
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
                        SizedBox(
                          height: 15,
                        ),
                        Text("New User")
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
      borderSide: BorderSide(
        color: Colors.red,
        width: 2.0,
      ),
    ),
  );
}

SidebarX sidemenu(SidebarXController controller) {
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
    footerDivider: divider,
    headerBuilder: (context, extended) {
      return SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            logosvg,
          ),
        ),
      );
    },
    controller: controller,
    items: const [
      SidebarXItem(icon: Icons.home, label: 'Dashboard'),
      SidebarXItem(icon: Icons.shopping_bag, label: 'Add Shop'),
      SidebarXItem(icon: Icons.person_add, label: 'Add User'),
      SidebarXItem(icon: Icons.task, label: 'All Shops'),
      SidebarXItem(icon: Icons.document_scanner, label: 'Document'),
      SidebarXItem(icon: Icons.circle_notifications, label: 'Notification'),
      SidebarXItem(icon: Icons.person, label: 'Profile'),
      SidebarXItem(icon: Icons.settings, label: 'Settings'),
    ],
  );
}
