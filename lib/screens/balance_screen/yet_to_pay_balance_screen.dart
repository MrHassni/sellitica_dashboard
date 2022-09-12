import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/order_provider.dart';

class YetToPayBalanceScreen extends StatefulWidget {
  const YetToPayBalanceScreen({Key? key}) : super(key: key);

  @override
  State<YetToPayBalanceScreen> createState() => _YetToPayBalanceScreenState();
}

class _YetToPayBalanceScreenState extends State<YetToPayBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, provider, _child) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 10, bottom: 10),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Date",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Type",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Sale Man",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Payable",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.allOrdermodelforSpecificRetailer.length,
              itemBuilder: (context, position) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: () {
                                var date = DateTime.fromMillisecondsSinceEpoch(
                                    provider
                                        .allOrdermodelforSpecificRetailer[
                                            position]
                                        .timestamp);
                                return Text(
                                  '${date.day}-${date.month}-${date.year}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                );
                              }()),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Debit',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                          const Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'My Name',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  provider
                                      .allOrdermodelforSpecificRetailer[
                                          position]
                                      .grandtotal
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
