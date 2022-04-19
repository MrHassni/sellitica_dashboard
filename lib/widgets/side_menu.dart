// import 'package:erp_aspire/controllers/MenuController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:sidebarx/sidebarx.dart';
//
// import '../constants.dart';
// import '../responsive.dart';
// import '../screens/addShop/addShop.dart';
// import '../screens/addUser/addUser.dart';
// import '../screens/main/components/side_menu.dart';
// import '../screens/main/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../screens/addShop/addShop.dart';
import '../screens/addUser/addUser.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/shops/allshops.dart';

final divider = Divider(color: Colors.black.withOpacity(0.1), height: 1);
const canvasColor = Colors.white;
const accentCanvasColor = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);

// class drawer extends StatefulWidget {
//   const drawer({required this.child});
//
//   final Widget child;
//
//   @override
//   State<drawer> createState() => _drawerState();
// }
//
// class _drawerState extends State<drawer> {
//   final _controller = SidebarXController(selectedIndex: 0);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MenuController>(builder: (context, provider, _child) {
//       return WillPopScope(
//         onWillPop: () async => true,
//         child: Scaffold(
//           // key: provider.scaffoldKey,
//           drawer: const SideMenu(),
//           body: SafeArea(
//             child: Row(
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // We want this side menu only for large screen
//                 if (Responsive.isDesktop(context))
//                   SidebarX(
//                     // controller: _controller,
//                     theme: SidebarXTheme(
//                       margin: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: canvasColor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       textStyle: const TextStyle(color: Colors.black),
//                       selectedTextStyle: const TextStyle(color: Colors.black),
//                       itemTextPadding: const EdgeInsets.only(left: 30),
//                       selectedItemTextPadding: const EdgeInsets.only(left: 30),
//                       itemDecoration: BoxDecoration(
//                         border: Border.all(color: canvasColor),
//                       ),
//                       selectedItemDecoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: actionColor.withOpacity(0.37),
//                         ),
//                         gradient: const LinearGradient(
//                           colors: [accentCanvasColor, canvasColor],
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                           )
//                         ],
//                       ),
//                       iconTheme: const IconThemeData(
//                         color: Colors.black,
//                         size: 20,
//                       ),
//                     ),
//                     extendedTheme: const SidebarXTheme(
//                       width: 200,
//                       decoration: BoxDecoration(
//                         color: canvasColor,
//                       ),
//                       margin: EdgeInsets.only(right: 10),
//                     ),
//                     footerDivider: divider,
//                     headerBuilder: (context, extended) {
//                       return SizedBox(
//                         height: 150,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: SvgPicture.asset(
//                             logosvg,
//                           ),
//                         ),
//                       );
//                     },
//                     controller: _controller,
//                     items: const [
//                       SidebarXItem(icon: Icons.home, label: 'Dashboard'),
//                       SidebarXItem(icon: Icons.shopping_bag, label: 'Add Shop'),
//                       SidebarXItem(icon: Icons.person_add, label: 'Add User'),
//                       SidebarXItem(icon: Icons.task, label: 'Task'),
//                       SidebarXItem(
//                           icon: Icons.document_scanner, label: 'Document'),
//                       SidebarXItem(
//                           icon: Icons.circle_notifications,
//                           label: 'Notification'),
//                       SidebarXItem(icon: Icons.person, label: 'Profile'),
//                       SidebarXItem(icon: Icons.settings, label: 'Settings'),
//                     ],
//                   ),
//                 Expanded(
//                   // It takes 5/6 part of the screen
//                   // flex: 5,
//                   child: body(
//                     controller: _controller,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
//

class body extends StatelessWidget {
  const body(
      {Key? key,
      required this.controller,
      this.Dashboardscreen,
      this.addshop,
      this.adduser})
      : super(key: key);
  final SidebarXController controller;
  final Widget? Dashboardscreen;
  final Widget? addshop;
  final Widget? adduser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return Dashboardscreen ?? DashboardScreen();
          case 1:
            return addshop ?? const addShop();
          case 2:
            return adduser ?? const addUser();

          case 3:
            return allshops();
          default:
            return Text(
              'Not found page',
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
}
