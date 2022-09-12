import 'package:erp_aspire/adativeScreen/screentypeLayout.dart';
import 'package:erp_aspire/screens/homescreen/widgets/homescreenweb.dart';
import 'package:flutter/material.dart';

class homescreen extends StatelessWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return screentypeLayout(
      web: const homescreenweb(),
      mobile: Container(),
    );
  }
}
