import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/addRetailerProvider.dart';
import '../../provider/shopsProvider.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import '../dashboard/components/storage_info_card.dart';

class allshops extends StatefulWidget {
  const allshops({Key? key}) : super(key: key);

  @override
  _allshopsState createState() => _allshopsState();
}

class _allshopsState extends State<allshops> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Provider.of<shopsProvider>(context).getShopsDataList();
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
            child: Consumer2<addRetailerProvider, shopsProvider>(
                builder: (context, provider, userprovider, _child) => Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Header(
                            title: 'Manage Shops',
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
                                    SizedBox(
                                      height: height - 140,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        primary: false,
                                        // physics:
                                        //     NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        // itemCount: 20,
                                        itemCount: userprovider.allShops.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 0),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              color: Colors.white,
                                              elevation: 5,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                              onPressed: () {
                                                userprovider
                                                    .mUpdateSelectedShop(
                                                        userprovider
                                                            .allShops[index]);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  // ClipRRect(
                                                  //   child: SizedBox(
                                                  //     height: 100,
                                                  //     width: 100,
                                                  //     child: Image.network(
                                                  //       userprovider
                                                  //           .allShops[index]
                                                  //           .url,
                                                  //       height: 100,
                                                  //       width: 100,
                                                  //       fit: BoxFit.cover,
                                                  //       cacheHeight: 100,
                                                  //       cacheWidth: 100,
                                                  //     ),
                                                  //   ),
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(
                                                  //           12),
                                                  // ),
                                                  // const SizedBox(
                                                  //   width: 10,
                                                  // ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              child: Text(
                                                                userprovider
                                                                    .allShops[
                                                                        index]
                                                                    .shopName,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              userprovider
                                                                  .allShops[
                                                                      index]
                                                                  .assignedto[0],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
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
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text.rich(TextSpan(
                                                                        text:
                                                                            'Owner ',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color: Color(
                                                                                0xFFFFA113),
                                                                            fontWeight: FontWeight
                                                                                .w500),
                                                                        children: <
                                                                            InlineSpan>[
                                                                          TextSpan(
                                                                            text:
                                                                                userprovider.allShops[index].ownerName.toString(),
                                                                            style: const TextStyle(
                                                                                fontSize: 12,
                                                                                letterSpacing: 0.5,
                                                                                color: const Color(0xFFFFA113),
                                                                                fontWeight: FontWeight.bold),
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
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text.rich(TextSpan(
                                                                        text:
                                                                            'Phone No. ',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                primaryColor,
                                                                            fontWeight: FontWeight
                                                                                .w500),
                                                                        children: <
                                                                            InlineSpan>[
                                                                          TextSpan(
                                                                            text:
                                                                                userprovider.allShops[index].phone.toString(),
                                                                            style: const TextStyle(
                                                                                fontSize: 12,
                                                                                letterSpacing: 0.5,
                                                                                color: primaryColor,
                                                                                fontWeight: FontWeight.bold),
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
                                                                  child:
                                                                      MaterialButton(
                                                                    onPressed:
                                                                        () {},
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    child: Container(
                                                                        // padding: EdgeInsets.all(
                                                                        //     defaultPadding *
                                                                        //         0.75),

                                                                        height: 40,
                                                                        width: 40,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              primaryColor.withOpacity(0.1),
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(10)),
                                                                        ),
                                                                        child: const Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                primaryColor,
                                                                            size:
                                                                                17,
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
                                                                  child:
                                                                      MaterialButton(
                                                                    onPressed:
                                                                        () async {},
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    child: Container(
                                                                        // padding: EdgeInsets.all(
                                                                        //     defaultPadding *
                                                                        //         0.75),

                                                                        height: 40,
                                                                        width: 40,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .red
                                                                              .withOpacity(0.1),
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(10)),
                                                                        ),
                                                                        child: const Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                17,
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
                                  child: SizedBox(
                                    height: height - 140,
                                    child: userprovider.selectedShop == null
                                        ? const Center(
                                            child: Text("Select any shop"),
                                          )
                                        : Card(
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: SingleChildScrollView(
                                              controller: ScrollController(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onHover: (isHovering) {
                                                        if (isHovering) {
                                                        } else {
                                                          //The mouse is no longer hovering.
                                                        }
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors
                                                            .grey.shade200,
                                                        maxRadius: 80,
                                                        minRadius: 30,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          userprovider
                                                              .selectedShop!
                                                              .url,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: userprovider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : userprovider
                                                                  .selectedShop!
                                                                  .ownerName
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Owner",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: userprovider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : userprovider
                                                                  .selectedShop!
                                                                  .shopName
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Shop",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: userprovider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : userprovider
                                                                  .selectedShop!
                                                                  .address
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Address",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: userprovider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : userprovider
                                                                  .selectedShop!
                                                                  .addedby
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles:
                                                              "Added by",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: userprovider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : userprovider
                                                                  .selectedShop!
                                                                  .cnic
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Cnic",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: userprovider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : userprovider
                                                                  .selectedShop!
                                                                  .phone
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Phone",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: userprovider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : userprovider
                                                                  .selectedShop!
                                                                  .type
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Type",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: userprovider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : userprovider
                                                                  .selectedShop!
                                                                  .assignedto
                                                                  .first
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles:
                                                              "Assigned To",
                                                        ),
                                                        SizedBox(height: 15)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
