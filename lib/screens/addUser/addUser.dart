import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/addRetailerProvider.dart';
import 'package:erp_aspire/provider/userProvider.dart';
import 'package:erp_aspire/screens/dashboard/components/header.dart';
import 'package:erp_aspire/widgets/regularWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants.dart';
import '../../responsive.dart';

class addUser extends StatelessWidget {
  const addUser({Key? key}) : super(key: key);

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
          child: SafeArea(
            child: Consumer2<addRetailerProvider, userProvider>(
                builder: (context, provider, userprovider, _child) =>
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Header(
                            title: 'Manage User/ Salesman',
                          ),
                          const SizedBox(height: defaultPadding),
                          ///////FORM WIDTH WILL BE FULL IN MOBILE VIEW AND HALF IN THE DESKTOP VIEW.
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (Responsive.isMobile(context))
                                      Column(
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
                                          TextFormField(
                                            controller:
                                                userprovider.emailController,
                                            decoration:
                                                inputdecoration(label: 'Email'),
                                          ),
                                          const SizedBox(
                                              height: defaultPadding),
                                          TextFormField(
                                            controller:
                                                userprovider.passwordController,
                                            decoration: inputdecoration(
                                                label: 'Password'),
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
                                                            .emailController
                                                            .text
                                                            .isNotEmpty &&
                                                        userprovider
                                                            .fullnameController
                                                            .text
                                                            .isNotEmpty &&
                                                        userprovider
                                                            .passwordController
                                                            .text
                                                            .isNotEmpty) {
                                                      userprovider
                                                          .mUploadNewUser(
                                                              context);
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
                                    ListView.separated(
                                      shrinkWrap: true,
                                      // primary: false,
                                      // physics:
                                      //     NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      // itemCount: 20,
                                      itemCount: userprovider.allusers.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            color: Colors.white,
                                            elevation: 5,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      child: Text(
                                                        userprovider
                                                            .allusers[index]
                                                            .name,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      userprovider
                                                          .allusers[index]
                                                          .email,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Wrap(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                      0xFFFFA113)
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text.rich(TextSpan(
                                                                text:
                                                                    'Target Orders ',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xFFFFA113),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                    text: userprovider
                                                                        .allusers[
                                                                            index]
                                                                        .targetorders
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        letterSpacing:
                                                                            0.5,
                                                                        color: const Color(
                                                                            0xFFFFA113),
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ])),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: primaryColor
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text.rich(TextSpan(
                                                                text:
                                                                    'Target shops ',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                    text: userprovider
                                                                        .allusers[
                                                                            index]
                                                                        .targetshops
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        letterSpacing:
                                                                            0.5,
                                                                        color:
                                                                            primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ])),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 40,
                                                          width: 40,
                                                          child: MaterialButton(
                                                            onPressed: () {},
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Container(
                                                                // padding: EdgeInsets.all(
                                                                //     defaultPadding *
                                                                //         0.75),

                                                                height: 40,
                                                                width: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: primaryColor
                                                                      .withOpacity(
                                                                          0.1),
                                                                  borderRadius: const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          10)),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons.edit,
                                                                    color:
                                                                        primaryColor,
                                                                    size: 17,
                                                                  ),
                                                                )
                                                                // SvgPicture.asset(
                                                                //   info.svgSrc!,
                                                                //   color: info.color,
                                                                // ),
                                                                ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          width: 40,
                                                          child: MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              final response =
                                                                  await showOkCancelAlertDialog(
                                                                      context:
                                                                          context,
                                                                      title:
                                                                          "Are you sure!",
                                                                      message:
                                                                          "You want to delete this user.?");
                                                              if (response
                                                                      .toString() ==
                                                                  "OkCancelResult.ok") {
                                                                if (kDebugMode) {
                                                                  print(userprovider
                                                                      .allusers[
                                                                          index]
                                                                      .id);

                                                                  userprovider.mDeleteUsers(
                                                                      userprovider
                                                                          .allusers[
                                                                              index]
                                                                          .id,
                                                                      userprovider
                                                                          .allusers[
                                                                              index]
                                                                          .email);
                                                                }
                                                              }
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Container(
                                                                // padding: EdgeInsets.all(
                                                                //     defaultPadding *
                                                                //         0.75),

                                                                height: 40,
                                                                width: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red
                                                                      .withOpacity(
                                                                          0.1),
                                                                  borderRadius: const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          10)),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 17,
                                                                  ),
                                                                )
                                                                // SvgPicture.asset(
                                                                //   info.svgSrc!,
                                                                //   color: info.color,
                                                                // ),
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          width: 20,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                const SizedBox(width: defaultPadding),
                              // On Mobile means if the screen is less than 850 we dont want to show it
                              if (!Responsive.isMobile(context))
                                Expanded(
                                  flex: 2,
                                  child:
                                      // SizedBox()
                                      Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Add Users/ Salesman",
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
                                              controller: userprovider
                                                  .fullnameController,
                                              decoration: inputdecoration(
                                                  label: 'Full name'),
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            TextFormField(
                                              controller:
                                                  userprovider.emailController,
                                              decoration: inputdecoration(
                                                  label: 'Email'),
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            TextFormField(
                                              controller: userprovider
                                                  .passwordController,
                                              decoration: inputdecoration(
                                                  label: 'Password'),
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
                                                              .emailController
                                                              .text
                                                              .isNotEmpty &&
                                                          userprovider
                                                              .fullnameController
                                                              .text
                                                              .isNotEmpty &&
                                                          userprovider
                                                              .passwordController
                                                              .text
                                                              .isNotEmpty) {
                                                        userprovider
                                                            .mUploadNewUser(
                                                                context);
                                                      } else {
                                                        userprovider
                                                            .btnController
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
                                                            color:
                                                                Colors.white),
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
          ),
        )),
      ),
    );
  }
}
