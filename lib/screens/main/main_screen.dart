import 'package:erp_aspire/provider/addRetailerProvider.dart';
import 'package:erp_aspire/provider/homeProvider.dart';
import 'package:erp_aspire/provider/userProvider.dart';
import 'package:erp_aspire/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import '../../widgets/regularWidgets.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
  final SidebarXController controller;
}

class _MainScreenState extends State<MainScreen> {
  // final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuController>(builder: (context, provider, _child) {
      return WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          // key: provider.scaffoldKey,
          drawer: const SideMenu(),
          body: SafeArea(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context)) sidemenu(widget.controller),
                Expanded(
                  // It takes 5/6 part of the screen
                  // flex: 5,
                  child: body(
                    controller: widget.controller,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    mInIt(context);
  }

  addRetailerProvider? retailerProvider;
  userProvider? userprovider;
  homepage_provider? homeprovider;

  mInIt(BuildContext context) {
    homeprovider = Provider.of<homepage_provider>(context, listen: false);
    retailerProvider = Provider.of<addRetailerProvider>(context, listen: false);
    userprovider = Provider.of<userProvider>(context, listen: false);

    homeprovider!.getOrdersDataList();
    retailerProvider!.mGetLocationPermission().then((value) {
      retailerProvider!.mSetCurrentLocation();
    });
    userprovider!.mGetUserDetails().then((value) {
      userprovider!.mGetAllUsers();
    });
  }
}
