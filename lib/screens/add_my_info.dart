import 'dart:async';

import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/addRetailerProvider.dart';
import 'package:erp_aspire/provider/userProvider.dart';
import 'package:erp_aspire/screens/dashboard/components/header.dart';
import 'package:erp_aspire/widgets/regularWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../constants.dart';
import '../../responsive.dart';
import '../Provider/money_provider.dart';
import '../provider/company_provider.dart';
import '../provider/homeProvider.dart';
import 'add_company.dart';

class AddMyInfo extends StatefulWidget {
  const AddMyInfo({Key? key}) : super(key: key);

  @override
  State<AddMyInfo> createState() => _AddMyInfoState();
}

class _AddMyInfoState extends State<AddMyInfo> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.all(20),
      child: Scaffold(
        body: SafeArea(
            child: Container(
          height: height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Consumer2<addRetailerProvider, userProvider>(
              builder: (context, provider, userprovider, _child) =>
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Header(
                          title: 'Add Your Name',
                        ),
                        const SizedBox(height: defaultPadding),
                        ///////FORM WIDTH WILL BE FULL IN MOBILE VIEW AND HALF IN THE DESKTOP VIEW.
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (Responsive.isMobile(context))
                                  Column(
                                    children: [
                                      const SizedBox(height: defaultPadding),
                                      TextFormField(
                                        controller:
                                            userprovider.fullnameController,
                                        decoration:
                                            inputdecoration(label: 'Full name'),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: RoundedLoadingButton(
                                              borderRadius: 12,
                                              controller:
                                                  userprovider.btnController,
                                              color: primaryColor,
                                              onPressed: () async {
                                                if (userprovider
                                                        .fullnameController
                                                        .text
                                                        .isNotEmpty &&
                                                    userprovider
                                                        .passwordController
                                                        .text
                                                        .isNotEmpty) {
                                                  userprovider
                                                      .mUploadMyData(context);
                                                } else {
                                                  userprovider.btnController
                                                      .error();
                                                  mShowNotificationError(
                                                      heading: "Warning",
                                                      context: context,
                                                      message:
                                                          "Please fill all required fields");
                                                  Timer(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {
                                                    userprovider.btnController
                                                        .reset();
                                                  });
                                                }
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Upload",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            if (!Responsive.isMobile(context))
                              const SizedBox(width: defaultPadding),
                            // On Mobile means if the screen is less than 850 we dont want to show it
                            if (!Responsive.isMobile(context))
                              Expanded(
                                child:
                                    // SizedBox()
                                    Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Add Your Name j",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                    SizedBox(
                                      height: height / 1.25,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                              height: defaultPadding),
                                          TextFormField(
                                            controller:
                                                userprovider.fullnameController,
                                            decoration: inputdecoration(
                                                label: 'Full name'),
                                          ),
                                          const SizedBox(
                                              height: defaultPadding),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: RoundedLoadingButton(
                                                  borderRadius: 12,
                                                  controller: userprovider
                                                      .btnController,
                                                  color: primaryColor,
                                                  onPressed: () async {
                                                    if (userprovider
                                                        .fullnameController
                                                        .text
                                                        .isNotEmpty) {
                                                      userprovider
                                                          .mUploadMyData(
                                                              context)
                                                          .then((_) {
                                                        Provider.of<userProvider>(
                                                                context,
                                                                listen: false)
                                                            .mGetUserDetails()
                                                            .then((value) {
                                                          Provider.of<userProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .current_user;
                                                          Provider.of<homepage_provider>(
                                                                  context,
                                                                  listen: false)
                                                              .getOrdersDataList()
                                                              .then((_) {
                                                            Provider.of<CompanyProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getMyCompany()
                                                                .then((_) {
                                                              Timer(
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                                  () {
                                                                final _controller =
                                                                    SidebarXController(
                                                                        selectedIndex:
                                                                            0);
                                                                if (Provider.of<CompanyProvider>(context, listen: false).myCompanyData!.companyId != '' ||
                                                                    Provider.of<CompanyProvider>(context, listen: false)
                                                                            .myCompanyData!
                                                                            .companyImgUrl !=
                                                                        '' ||
                                                                    Provider.of<CompanyProvider>(context,
                                                                                listen: false)
                                                                            .myCompanyData!
                                                                            .companyName !=
                                                                        '') {
                                                                  Provider.of<MoneyProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .getTransactions()
                                                                      .then(
                                                                          (_) {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/homepage',
                                                                        arguments:
                                                                            _controller);
                                                                  });
                                                                } else {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const AddCompany()));
                                                                }
                                                              });
                                                            });
                                                          });
                                                        });
                                                      });
                                                    } else {
                                                      userprovider.btnController
                                                          .error();
                                                      mShowNotificationError(
                                                          heading: "Warning",
                                                          context: context,
                                                          message:
                                                              "Please fill all required fields");
                                                      Timer(
                                                          const Duration(
                                                              milliseconds:
                                                                  500), () {
                                                        userprovider
                                                            .btnController
                                                            .reset();
                                                      });
                                                    }
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Upload",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )),
        )),
      ),
    );
  }
}
