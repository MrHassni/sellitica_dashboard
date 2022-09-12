import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/money_provider.dart';
import '../../constants.dart';
import '../../provider/company_provider.dart';
import '../../provider/shopsProvider.dart';
import '../../responsive.dart';
import 'components/header.dart';
import 'components/my_fields.dart';
import 'components/sales_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController? _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    // if (!mounted) {
    //   Provider.of<ordersModificationProvider>(context, listen: false)
    //       .mResetList();
    //   log('Reset');
    // }
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setInitial(context);
    // });
  }

  setInitial(BuildContext context) async {
    Provider.of<ShopsProvider>(context, listen: false).getShopsDataList();
    Provider.of<CompanyProvider>(context, listen: false)
        .getMyCompany()
        .then((_) {
      Provider.of<MoneyProvider>(context, listen: false).getTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        // physics: ,
        controller: _controller,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            width < 1100
                ? Container()
                : const Header(
                    title: 'Dashboard',
                  ),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const MyFiles(),
                      const SizedBox(height: defaultPadding),
                      const sales_chart(),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      // if (Responsive.isMobile(context)) const StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                // if (!Responsive.isMobile(context))
                //   const Expanded(
                //     flex: 2,
                //     child: StarageDetails(),
                //   ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
