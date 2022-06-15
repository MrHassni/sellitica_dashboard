import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:erp_aspire/provider/addRetailerProvider.dart';
import 'package:erp_aspire/provider/authenticationProvider.dart';
import 'package:erp_aspire/provider/homeProvider.dart';
import 'package:erp_aspire/provider/ordersModificationProvider.dart';
import 'package:erp_aspire/provider/shopsProvider.dart';
import 'package:erp_aspire/provider/userProvider.dart';
import 'package:erp_aspire/screens/splashscreen/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'controllers/MenuController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: userProvider(),
        ),
        ChangeNotifierProvider.value(value: addRetailerProvider()),
        ChangeNotifierProvider.value(value: shopsProvider()),
        ChangeNotifierProvider(
          create: (context) => authenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
        ChangeNotifierProvider(
          create: (context) => homepage_provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ordersModificationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sellitica',
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: txtColor),
          // canvasColor: secondaryColor,
        ),
        home: const splashScreen(),
        // home: Container(
        //   color: Colors.red,
        //   height: MediaQuery.of(context).size.height / 3,
        //   width: 50,
        // ),
      ),
    );
  }
}
