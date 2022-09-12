import 'package:erp_aspire/screens/balance_screen/payed_balance_screen.dart';
import 'package:erp_aspire/screens/balance_screen/yet_to_pay_balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/order_provider.dart';

class balance_Screen extends StatefulWidget {
  final String? shopId, email;
  final double payed, yetToPay;
  const balance_Screen(
      {Key? key,
      this.shopId,
      required this.yetToPay,
      required this.payed,
      required this.email})
      : super(key: key);

  @override
  _balance_ScreenState createState() => _balance_ScreenState();
}

class _balance_ScreenState extends State<balance_Screen>
    with SingleTickerProviderStateMixin {
  double headerSize = 15;
  double itemsSize = 12;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Consumer<OrderProvider>(
            builder: (context, provider, _child) => Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Total Bills",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                      () {
                        provider.getSpecificRetailerOrdersDataList(
                            shopID: widget.shopId!, email: widget.email!);

                        return Text(
                          widget.yetToPay.toString(),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        );
                      }(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                    child: SizedBox(
                  child: VerticalDivider(
                    //  color: salesappGrey,
                    thickness: 2,
                    endIndent: 0,
                  ),
                  height: 30,
                )),
                Container(
                    margin: const EdgeInsets.only(left: 75, right: 75),
                    constraints:
                        BoxConstraints.loose(const Size.fromHeight(0.0)),
                    // decoration: BoxDecoration(color: Colors.black),
                    child: Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        // overflow: Overflow.visible,
                        children: const [
                          Positioned(
                              top: -8.0,
                              left: 0.0,
                              right: 0.0,
                              child: Divider(
                                ///     color: salesappGrey,
                                thickness: 2,
                              ))
                        ])),
                Container(
                  margin: const EdgeInsets.only(left: 67, right: 67),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        child: VerticalDivider(
                          //  color: salesappGrey,
                          thickness: 2,
                          endIndent: 0,
                        ),
                        height: 45,
                      ),
                      SizedBox(
                        child: VerticalDivider(
                          //    color: salesappGrey,
                          thickness: 2,
                          endIndent: 0,
                        ),
                        height: 45,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 52, right: 52, top: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Payed",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          Text(
                            widget.payed.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Yet To Pay",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            (widget.yetToPay - widget.payed).toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 325,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(55),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        leading: Container(),
                        elevation: 0.0,
                        bottom: TabBar(
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          labelPadding:
                              const EdgeInsets.only(left: 0.0, right: 0.0),
                          indicatorWeight: 10,
                          indicator: const ShapeDecoration(
                            shape: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                          ),
                          controller: _tabController,
                          tabs: [
                            Container(
                              height: 30,
                              alignment: Alignment.center,
                              color: Colors.white,
                              child: Text(
                                "Payed",
                                style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Container(
                              height: 30,
                              alignment: Alignment.center,
                              color: Colors.white,
                              child: Text(
                                "Payable",
                                style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(
                      controller: _tabController,
                      children: const [
                        PayedBalanceScreen(),
                        YetToPayBalanceScreen()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
