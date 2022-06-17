import 'package:erp_aspire/screens/addProducts/addProducts.dart';
import 'package:erp_aspire/screens/addShop/addShop.dart';
import 'package:erp_aspire/screens/addShop/sales_maps.dart';
import 'package:erp_aspire/screens/addUser/addUser.dart';
import 'package:erp_aspire/screens/loginscreen/loginscreen.dart';
import 'package:erp_aspire/screens/main/main_screen.dart';
import 'package:erp_aspire/screens/orders/pendingOrders.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

const String homepage = '/homepage';
const String login = '/login';
const String addshop = '/addshop';
const String salesmaps = '/salesmaps';
const String adduser = '/adduser';
const String pendingorders = '/pendingorders';
const String addproducts = '/addproducts';

// const String salesMapsVisit = '/salesMapsVisit';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homepage:
      return MaterialPageRoute(
          builder: (_) =>
              MainScreen(controller: settings.arguments as SidebarXController));
    case login:
      return MaterialPageRoute(builder: (_) => loginscreen());

    case addshop:
      return MaterialPageRoute(builder: (_) => addShop());

    case adduser:
      return MaterialPageRoute(builder: (_) => addUser());

    case salesmaps:
      return MaterialPageRoute(builder: (_) => sales_maps());
    case addproducts:
      return MaterialPageRoute(builder: (_) => const AddProducts());
    case pendingorders:
      return MaterialPageRoute(
          builder: (_) => pendingOrders(
                type: int.parse(settings.arguments.toString()),
              ));

    // case salesMapsVisit:
    // return MaterialPageRoute(builder: (_) => sales_maps_visit());

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
