import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: SvgPicture.asset(
              logosvg,
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              final _controller = SidebarXController(selectedIndex: 0);
              Navigator.pushReplacementNamed(context, Router.homepage,
                  arguments: _controller);
            },
          ),
          ExpansionTile(
            tilePadding: const EdgeInsets.all(0),
            title: const DrawerListTile(
              title: "Add new",
              svgSrc: "assets/icons/menu_tran.svg",
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DrawerListTile(
                  title: "New Shop",
                  svgSrc: "assets/icons/menu_store.svg",
                  press: () {
                    Navigator.pushReplacementNamed(context, Router.addshop);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DrawerListTile(
                  title: "New User",
                  svgSrc: "assets/icons/menu_profile.svg",
                  press: () {
                    Navigator.pushReplacementNamed(context, Router.adduser);
                  },
                ),
              ),
            ],
          ),
          DrawerListTile(
            title: "Task",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Documents",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Store",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: txtColor,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: txtColor),
      ),
    );
  }
}
