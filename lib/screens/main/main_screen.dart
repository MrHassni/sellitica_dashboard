import 'package:erp_aspire/provider/addRetailerProvider.dart';
import 'package:erp_aspire/provider/authenticationProvider.dart';
import 'package:erp_aspire/provider/homeProvider.dart';
import 'package:erp_aspire/provider/userProvider.dart';
import 'package:erp_aspire/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../provider/shopsProvider.dart';
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

  late final SidebarXController _ctrl = widget.controller;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: width < 1100
            ? AppBar(
                foregroundColor: Colors.black,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text('Dashboard'),
              )
            : PreferredSize(
                child: Container(), preferredSize: const Size.fromHeight(0)),
        // key: Provider.of<MenuController>(context, listen: false).scaffoldKey,
        // key: provider.scaffoldKey,
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                sidemenu(widget.controller, context),
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
  }

  @override
  void initState() {
    super.initState();
    mInIt(context);
    Provider.of<authenticationProvider>(context, listen: false).done();
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
    Provider.of<ShopsProvider>(context, listen: false).getShopsDataList();
    userprovider!.mGetUserDetails().then((value) {
      userprovider!.mGetAllUsers();
    });
  }
}
