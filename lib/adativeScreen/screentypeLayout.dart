import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class screentypeLayout extends StatelessWidget {
  const screentypeLayout({Key? key, required this.mobile, required this.web})
      : super(key: key);
  final Widget mobile;
  final Widget web;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: mobile,
      tablet: mobile,
      desktop: web,
    );
  }
}
