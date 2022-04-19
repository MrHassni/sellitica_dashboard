import 'package:flutter/material.dart';

import '../constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage, subtitle, tagline;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.subtitle,
    this.tagline,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "7832.7 K",
    subtitle: "Pending Orders",
    tagline: "Compare to 10 months before",
    numOfFiles: 0,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "340453 K",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "23890477 M",
    subtitle: "In process Orders",
    numOfFiles: 1,
    svgSrc: "assets/icons/google_drive.svg",
    tagline: "Compare to 10 months before",
    totalStorage: "2897845 M",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "4389534 M",
    subtitle: "Delivered Orders",
    numOfFiles: 2,
    svgSrc: "assets/icons/one_drive.svg",
    tagline: "Compare to 10 months before",
    totalStorage: "12389534 M",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "345345 M",
    subtitle: "Others",
    numOfFiles: 3,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "145345 M",
    tagline: "Compare to 10 months before",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
