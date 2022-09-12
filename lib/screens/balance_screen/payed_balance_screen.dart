import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/money_provider.dart';

class PayedBalanceScreen extends StatefulWidget {
  const PayedBalanceScreen({Key? key}) : super(key: key);

  @override
  State<PayedBalanceScreen> createState() => _PayedBalanceScreenState();
}

class _PayedBalanceScreenState extends State<PayedBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Consumer<MoneyProvider>(
      builder: (context, moneyProvider, _child) => Column(
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
                          "Payed By",
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
                          "Payed To",
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
                          "Amount",
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
            itemCount: moneyProvider.allTransactions.length,
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
                                  moneyProvider
                                      .allTransactions[position].timestamp);
                              return Text(
                                '${date.day}-${date.month}-${date.year}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              );
                            }()),
                        Expanded(
                            flex: 2,
                            child: Text(
                              moneyProvider
                                  .allTransactions[position].paymentMethod,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black),
                            )),
                        Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                moneyProvider.allTransactions[position].payedBy,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                moneyProvider.allTransactions[position].payedTo,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                moneyProvider
                                    .allTransactions[position].amountPayed
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
    ));
  }
}
