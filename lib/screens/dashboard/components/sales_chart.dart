import 'package:erp_aspire/models/add_money_model.dart';
import 'package:erp_aspire/models/orderModel.dart';
import 'package:erp_aspire/provider/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Provider/money_provider.dart';
import '../../../constants.dart';

class sales_chart extends StatefulWidget {
  const sales_chart({Key? key}) : super(key: key);

  @override
  State<sales_chart> createState() => _sales_chartState();
}

class _sales_chartState extends State<sales_chart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  List<ChartModel> mySaleGraph = [];
  List<ChartModel> myAllOrdersSaleGraph = [];
  List<ChartModel> myCreditGraph = [];

  getList() {
    List<orderModel> list =
        Provider.of<homepage_provider>(context, listen: false)
            .completedOrdermodel;
    for (int i = 0; i < list.length; i++) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(list[i].timestamp);
      mySaleGraph.add(ChartModel(
          gdnCode: '${date.day}-${date.month}-${date.year}',
          saleTotal: list[i].grandtotal));
    }

    List<orderModel> listOfAll =
        Provider.of<homepage_provider>(context, listen: false).allOrdermodel;
    for (int i = 0; i < listOfAll.length; i++) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(listOfAll[i].timestamp);
      myAllOrdersSaleGraph.add(ChartModel(
          gdnCode: '${date.day}-${date.month}-${date.year}',
          saleTotal: listOfAll[i].grandtotal));
    }
    // Provider.of<MoneyProvider>(context, listen: false)
    //     .getTransactions()
    //     .then((_) {
    List<AddMoneyModel> allTrans =
        Provider.of<MoneyProvider>(context, listen: false).allShopsTransactions;
    for (int i = 0; i < allTrans.length; i++) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(allTrans[i].timestamp);
      myCreditGraph.add(ChartModel(
          gdnCode: '${date.day}-${date.month}-${date.year}',
          saleTotal: allTrans[i].amountPayed));
    }
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<ChartModel> saleGraph = [
      ChartModel(gdnCode: '40', saleTotal: 4800),
      ChartModel(gdnCode: '41', saleTotal: 12000),
      ChartModel(gdnCode: '42', saleTotal: 4000),
      ChartModel(gdnCode: '43', saleTotal: 6030),
      ChartModel(gdnCode: '44', saleTotal: 8050),
      ChartModel(gdnCode: '45', saleTotal: 6000),
      ChartModel(gdnCode: '46', saleTotal: 5000),
      ChartModel(gdnCode: '47', saleTotal: 9000),
      ChartModel(gdnCode: '48', saleTotal: 3000),
      ChartModel(gdnCode: '49', saleTotal: 7500),
      ChartModel(gdnCode: '50', saleTotal: 2800),
      // ChartModel(gdnCode: 51, saleTotal: 2000),
      // ChartModel(gdnCode: 52, saleTotal: 20000),
      // ChartModel(gdnCode: 53, saleTotal: 2001),
      // ChartModel(gdnCode: 54, saleTotal: 7000),
      // ChartModel(gdnCode: 55, saleTotal: 7000),
      // ChartModel(gdnCode: 56, saleTotal: 7000),
      // ChartModel(gdnCode: 57, saleTotal: 7000),
      // ChartModel(gdnCode: 58, saleTotal: 7000),
      // ChartModel(gdnCode: 59, saleTotal: 7500),
      // ChartModel(gdnCode: 60, saleTotal: 28800),
      // ChartModel(gdnCode: 61, saleTotal: 2000),
      // ChartModel(gdnCode: 62, saleTotal: 20000),
      // ChartModel(gdnCode: 63, saleTotal: 2001),
      // ChartModel(gdnCode: 64, saleTotal: 7000),
      // ChartModel(gdnCode: 65, saleTotal: 7000),
      // ChartModel(gdnCode: 66, saleTotal: 7000),
      // ChartModel(gdnCode: 67, saleTotal: 7000),
      // ChartModel(gdnCode: 68, saleTotal: 7000),
      // ChartModel(gdnCode: 69, saleTotal: 7500),
      // ChartModel(gdnCode: 70, saleTotal: 28800),
      // ChartModel(gdnCode: 71, saleTotal: 2000),
      // ChartModel(gdnCode: 72, saleTotal: 20000),
      // ChartModel(gdnCode: 73, saleTotal: 2001),
      // ChartModel(gdnCode: 74, saleTotal: 7000),
      // ChartModel(gdnCode: 75, saleTotal: 7000),
      // ChartModel(gdnCode: 76, saleTotal: 7000),
      // ChartModel(gdnCode: 77, saleTotal: 7000),
      // ChartModel(gdnCode: 78, saleTotal: 7000),
      // ChartModel(gdnCode: 79, saleTotal: 7500),
    ];

    List<ChartData> chartData = [
      ChartData(x: 'PRO', high: 1000, low: 200),
      ChartData(x: 'PRO1', high: 1200, low: 600),
      ChartData(x: 'PRO2', high: 800, low: 400),
      ChartData(x: 'PRO3', high: 1500, low: 1000),
      ChartData(x: 'PRO4', high: 600, low: 300),
      ChartData(x: 'PRO5', high: 900, low: 600),
      ChartData(x: 'PRO7', high: 500, low: 250),
      ChartData(x: 'PRO8', high: 200, low: 100),
      ChartData(x: 'PRO9', high: 400, low: 200),
      ChartData(x: 'PRO10', high: 120, low: 50),
      ChartData(x: 'PRO12', high: 2100, low: 1000),
      ChartData(x: 'PRO11', high: 450, low: 120),
      ChartData(x: 'PRO13', high: 120, low: 50),
    ];
    List<ChartData> yearlyGraph = [
      ChartData(x: 'JAN', high: 1000, low: 200),
      ChartData(x: 'FEB', high: 1200, low: 600),
      ChartData(x: 'MAR', high: 800, low: 400),
      ChartData(x: 'APR', high: 1500, low: 800),
      ChartData(x: 'MAY', high: 600, low: 300),
      ChartData(x: 'JUN', high: 900, low: 600),
      ChartData(x: 'JUL', high: 500, low: 250),
      ChartData(x: 'AUG', high: 200, low: 100),
      ChartData(x: 'SEP', high: 400, low: 200),
      ChartData(x: 'OCT', high: 120, low: 50),
      ChartData(x: 'NOV', high: 2100, low: 500),
      ChartData(x: 'DEC', high: 450, low: 120),
    ];

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sales Graph",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: saleGraphC(context,
                dateSource: mySaleGraph
                    .map((e) => ChartModel(
                        saleTotal: double.parse(e.saleTotal.toString()),
                        gdnCode: e.gdnCode.toString()))
                    .toList()),
          ),
          Text(
            "All Orders Placed Graph",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: saleGraphC1(context,
                dateSource: myAllOrdersSaleGraph
                    .map((e) => ChartModel(
                        saleTotal: double.parse(e.saleTotal.toString()),
                        gdnCode: e.gdnCode.toString()))
                    .toList()),
          ),
          Text(
            "Credit",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: saleGraphC2(context,
                dateSource: myCreditGraph
                    .map((e) => ChartModel(
                        saleTotal: double.parse(e.saleTotal.toString()),
                        gdnCode: e.gdnCode.toString()))
                    .toList()),
          ),
          // Text(
          //   "Price Range",
          //   style: Theme.of(context).textTheme.subtitle1,
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   child: saleGraphC3(
          //     context,
          //     chartData: chartData
          //         .map((e) => ChartData(
          //               high: double.parse(e.high.toString()),
          //               low: double.parse(e.low.toString()),
          //               x: e.x,
          //             ))
          //         .toList(),
          //   ),
          // ),
          // Text(
          //   "Sales Yearly",
          //   style: Theme.of(context).textTheme.subtitle1,
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   child: saleGraphC4(
          //     context,
          //     chartData: yearlyGraph
          //         .map((e) => ChartData(
          //               high: double.parse(e.high.toString()),
          //               low: double.parse(e.low.toString()),
          //               x: e.x,
          //             ))
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}

Widget saleGraphC(BuildContext context,
    {required List<ChartModel> dateSource}) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.all(16.0),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.3,
    child: SfCartesianChart(
        trackballBehavior: TrackballBehavior(
          lineColor: primaryColor,
          shouldAlwaysShow: false,
          activationMode: ActivationMode.singleTap,
          enable: true,
          tooltipSettings: const InteractiveTooltip(format: 'Rs. point.y'),
          tooltipAlignment: ChartAlignment.near,
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        ),
        plotAreaBackgroundColor: secondaryColor,
        primaryXAxis:
            CategoryAxis(labelStyle: const TextStyle(color: txtColor)),
        series: <CartesianSeries>[
          SplineAreaSeries<ChartModel, String>(
            markerSettings: const MarkerSettings(
                isVisible: false,
                shape: DataMarkerType.circle,
                color: txtColor,
                borderColor: txtColor),
            color: primaryColor,
            dataSource: dateSource,
            enableTooltip: false,
            xValueMapper: (ChartModel model, _) => model.gdnCode.toString(),
            yValueMapper: (ChartModel model, _) =>
                double.parse(model.saleTotal.toString()),
          )
        ]),
  );
}

Widget saleGraphC1(BuildContext context,
    {required List<ChartModel> dateSource}) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.all(16.0),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.3,
    child: SfCartesianChart(
        trackballBehavior: TrackballBehavior(
          lineColor: const Color(0xFFFFA113),
          shouldAlwaysShow: false,
          activationMode: ActivationMode.singleTap,
          enable: true,
          tooltipSettings: const InteractiveTooltip(format: 'Rs. point.y'),
          tooltipAlignment: ChartAlignment.near,
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        ),
        plotAreaBackgroundColor: secondaryColor,
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
          ColumnSeries<ChartModel, String>(
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.none,
            ),
            // color: Color(0xFFFFA113).withOpacity(0.8),
            color: const Color(0xFFFFA113),
            dataSource: dateSource,
            enableTooltip: false,
            xValueMapper: (ChartModel model, _) => model.gdnCode.toString(),
            yValueMapper: (ChartModel model, _) =>
                double.parse(model.saleTotal.toString()),
          ),
          // LineSeries<ChartModel, String>(
          //   markerSettings: const MarkerSettings(
          //     isVisible: true,
          //     shape: DataMarkerType.none,
          //   ),
          //   color: Color(0xFFFFA113),
          //   dataSource: dateSource,
          //   xValueMapper: (ChartModel model, _) =>
          //       int.parse(model.gdnCode.toString()).toString(),
          //   yValueMapper: (ChartModel model, _) =>
          //       double.parse(model.saleTotal.toString()),
          // )
        ]),
  );
}

Widget saleGraphC2(BuildContext context,
    {required List<ChartModel> dateSource}) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.all(16.0),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.3,
    child: SfCartesianChart(
        trackballBehavior: TrackballBehavior(
          lineColor: const Color(0xFFA4CDFF),
          shouldAlwaysShow: false,
          activationMode: ActivationMode.singleTap,
          enable: true,
          tooltipSettings: const InteractiveTooltip(format: 'Rs. point.y'),
          tooltipAlignment: ChartAlignment.near,
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        ),
        plotAreaBackgroundColor: secondaryColor,
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
          BarSeries<ChartModel, String>(
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.none,
            ),
            color: const Color(0xFFA4CDFF),
            dataSource: dateSource,
            enableTooltip: false,
            width: 1.2, // Width of the bars
            spacing: 0.6,
            xValueMapper: (ChartModel model, _) => model.gdnCode.toString(),
            yValueMapper: (ChartModel model, _) =>
                double.parse(model.saleTotal.toString()),
            // borderRadius: BorderRadius.only(
            //     topRight: Radius.circular(5),
            //     bottomRight: Radius.circular(5))
          )
        ]),
  );
}

Widget saleGraphC3(BuildContext context, {required List<ChartData> chartData}) {
  return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          trackballBehavior: TrackballBehavior(
            lineColor: const Color(0xFFA4CDFF),
            shouldAlwaysShow: false,
            activationMode: ActivationMode.singleTap,
            enable: true,
            tooltipSettings: const InteractiveTooltip(
                format: 'Low. point.low \nHigh. point.high'),
            tooltipAlignment: ChartAlignment.near,
            tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          ),
          plotAreaBackgroundColor: secondaryColor,
          series: <ChartSeries>[
            RangeColumnSeries<ChartData, String>(
              dataSource: chartData,
              color: Colors.green,
              xValueMapper: (ChartData sales, _) => sales.x,
              lowValueMapper: (ChartData sales, _) => sales.low,
              highValueMapper: (ChartData sales, _) => sales.high,
              dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                  labelAlignment: ChartDataLabelAlignment.top),
            )
          ]));
}

Widget saleGraphC4(BuildContext context, {required List<ChartData> chartData}) {
  return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          trackballBehavior: TrackballBehavior(
            lineColor: Color(0xFFA4CDFF),
            shouldAlwaysShow: false,
            activationMode: ActivationMode.singleTap,
            enable: true,
            tooltipSettings: const InteractiveTooltip(
                format: 'Low. point.low \nHigh. point.high'),
            tooltipAlignment: ChartAlignment.near,
            tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          ),
          plotAreaBackgroundColor: secondaryColor,
          series: <ChartSeries>[
            HiloSeries<ChartData, String>(
              dataSource: chartData,
              color: const Color(0xFFA4CDFF),
              xValueMapper: (ChartData sales, _) => sales.x,
              lowValueMapper: (ChartData sales, _) => sales.low,
              highValueMapper: (ChartData sales, _) => sales.high,
              borderWidth: 10.0,
              dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                  labelAlignment: ChartDataLabelAlignment.top),
            ),
          ]));
}

class ChartData {
  ChartData({required this.x, required this.high, required this.low});

  final String x;
  final double high;
  final double low;
}

class ChartModel {
  String gdnCode;
  double saleTotal;

  ChartModel({
    required this.gdnCode,
    required this.saleTotal,
  });
}
