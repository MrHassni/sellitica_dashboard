import 'package:erp_aspire/screens/dashboard/components/radial_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expense Breakdown",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Manufacturing Material",
            amountOfFiles: "28%",
            numOfFiles: 324451234,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Printing Expense",
            amountOfFiles: "35%",
            numOfFiles: 565674325,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Adore Aluminium Tubes",
            amountOfFiles: "54%",
            numOfFiles: 485923498,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Meezan Bank Limited SHAD",
            amountOfFiles: "28%",
            numOfFiles: 123435,
          ),
          SizedBox(height: 30),
          Text(
            "Customer Recievable",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          radialChart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Manufacturing Material",
            amountOfFiles: "28%",
            numOfFiles: 324451234,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Printing Expense",
            amountOfFiles: "35%",
            numOfFiles: 565674325,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Adore Aluminium Tubes",
            amountOfFiles: "54%",
            numOfFiles: 485923498,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Meezan Bank Limited SHAD",
            amountOfFiles: "28%",
            numOfFiles: 123435,
          ),
        ],
      ),
    );
  }
}
