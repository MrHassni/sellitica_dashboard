import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants.dart';

class radialChart extends StatelessWidget {
  const radialChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          // PieChart(
          //   PieChartData(
          //     sectionsSpace: 0,
          //     centerSpaceRadius: 70,
          //     startDegreeOffset: -90,
          //     sections: paiChartSelectionDatas,
          //   ),
          // ),
          SfCircularChart(
              // legend: Legend(
              //     isVisible: true,
              //     orientation: LegendItemOrientation.vertical,
              //     // Legend will be placed at the left
              //     position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(
                  enable: true,
                  shouldAlwaysShow: false,
                  canShowMarker: false,
                  format: 'point.y% \npoint.x '),
              series: <CircularSeries>[
                DoughnutSeries<PieChartSectionData, String>(
                    // radius: "550",
                    enableTooltip: true,
                    // startAngle: 270, // starting angle of pie
                    // endAngle: 90,
                    dataSource: paiChartSelectionDatas,
                    xValueMapper: (PieChartSectionData data, _) => data.title,
                    yValueMapper: (PieChartSectionData data, _) => data.value,
                    // explode: true,
                    // First segment will be exploded on initial rendering
                    // explodeIndex: 1,
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        // color: txtColor,
                        // Positioning the data label
                        labelPosition: ChartDataLabelPosition.outside)

                    // Radius for each segment from data source
                    // pointRadiusMapper: (PieChartSectionData data, _) =>
                    //     data.radius.toString() + "%"
                    )
              ]),
          // Positioned.fill(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(height: defaultPadding),
          //       Text(
          //         "29 %",
          //         style: Theme.of(context).textTheme.headline4!.copyWith(
          //               color: Colors.white,
          //               fontWeight: FontWeight.w600,
          //               height: 0.5,
          //             ),
          //       ),
          //       Text("of 100%")
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    title: "Manufacturing Material",
    color: primaryColor,
    value: 25,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    title: "Printing Expense",
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    title: "Adore Aluminium Expe",
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    title: "Meezan Bank Limited",
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    title: "Marketing Staff ",
    color: primaryColor.withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];
