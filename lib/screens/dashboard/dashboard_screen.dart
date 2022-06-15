import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/header.dart';
import 'components/my_fields.dart';
import 'components/sales_chart.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  ScrollController? _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        // physics: ,
        controller: _controller,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              title: 'Dashboard',
            ),
            SizedBox(height: defaultPadding),
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
                      if (Responsive.isMobile(context)) const StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  const Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
