import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_aspire/provider/shopsProvider.dart';
import 'package:erp_aspire/screens/products_cloud_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Configs/Dbkeys.dart';
import '../Configs/Dbpaths.dart';
import '../Provider/money_provider.dart';
import '../constants.dart';
import '../provider/order_provider.dart';
import 'addShop/edit_shop.dart';
import 'addUser/live_location_map.dart';
import 'balance_screen/balance_screen.dart';

class ShopsCloudFirestoreSearch extends StatefulWidget {
  final String company;
  const ShopsCloudFirestoreSearch({Key? key, required this.company})
      : super(key: key);

  @override
  _ShopsCloudFirestoreSearchState createState() =>
      _ShopsCloudFirestoreSearchState();
}

class _ShopsCloudFirestoreSearchState extends State<ShopsCloudFirestoreSearch> {
  String? name = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search...'),
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: StreamBuilder<QuerySnapshot>(
            stream: (name != "" && name != null)
                ? FirebaseFirestore.instance
                    .collection(DbPaths.companies)
                    .doc(widget.company)
                    .collection(DbPaths.shops)
                    .orderBy('shopName')
                    .startAt([upperLetter(name!)]).endAt(
                        [upperLetter(name!) + '\uf8ff']).snapshots()
                : FirebaseFirestore.instance
                    .collection(DbPaths.companies)
                    .doc(widget.company)
                    .collection(DbPaths.shops)
                    .orderBy('timestamp')
                    .limit(20)
                    .snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting &&
                      !snapshot.hasData)
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.white,
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            onPressed: () {
                              Provider.of<ShopsProvider>(context, listen: false)
                                  .mUpdateSelectedShop(ShopsProfile(
                                      id: data[Dbkeys.id],
                                      type: data[Dbkeys.type],
                                      ownerName: data[Dbkeys.ownerName],
                                      phone: data[Dbkeys.phone],
                                      approved: data[Dbkeys.approved],
                                      typeId: data[Dbkeys.typeId],
                                      addedby: data[Dbkeys.addedby],
                                      assignedto: data[Dbkeys.assignedto],
                                      timestamp: data[Dbkeys.timestamp],
                                      url: data[Dbkeys.url],
                                      address: data[Dbkeys.address],
                                      latlong: data[Dbkeys.latlong],
                                      cnic: data[Dbkeys.cnic],
                                      company: data[Dbkeys.company],
                                      shopName: data[Dbkeys.shopName],
                                      targeted: data['targeted'],
                                      targetUpdateTime:
                                          data['targetUpdateTime'],
                                      lastVisit: data['lastVisit']));
                              Provider.of<ShopsProvider>(context, listen: false)
                                  .allAttendance
                                  .clear();
                              Provider.of<ShopsProvider>(context, listen: false)
                                  .getShopAttendance();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            child: Text(
                                              data['shopName'],
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text.rich(TextSpan(
                                              text: 'Assigned To :  ',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black
                                                      .withOpacity(0.9),
                                                  fontWeight: FontWeight.w500),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: data['assignedto'][0],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      letterSpacing: 0.5,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ])),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MediaQuery.of(context).size.width <
                                                  500
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                                  0xFFFFA113)
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text.rich(TextSpan(
                                                            text: 'Owner: ',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xFFFFA113),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            children: <
                                                                InlineSpan>[
                                                              TextSpan(
                                                                text: data[
                                                                    'ownerName'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        0.5,
                                                                    color: Color(
                                                                        0xFFFFA113),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ])),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: primaryColor
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text.rich(TextSpan(
                                                            text: 'Phone No. ',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            children: <
                                                                InlineSpan>[
                                                              TextSpan(
                                                                text: data[
                                                                        'phone']
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        0.5,
                                                                    color:
                                                                        primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ])),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Wrap(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                                  0xFFFFA113)
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text.rich(TextSpan(
                                                            text: 'Owner: ',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xFFFFA113),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            children: <
                                                                InlineSpan>[
                                                              TextSpan(
                                                                text: data[
                                                                    'ownerName'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        0.5,
                                                                    color: Color(
                                                                        0xFFFFA113),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text.rich(TextSpan(
                                                            text: 'Phone No. ',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            children: <
                                                                InlineSpan>[
                                                              TextSpan(
                                                                text: data[
                                                                        'phone']
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        0.5,
                                                                    color:
                                                                        primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ])),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Wrap(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Provider.of<MoneyProvider>(
                                                          context,
                                                          listen: false)
                                                      .getAllTransactions(
                                                          data['id'])
                                                      .then((_) {
                                                    double totalPayed = 0;
                                                    var transactionList = Provider
                                                            .of<MoneyProvider>(
                                                                context,
                                                                listen: false)
                                                        .allTransactions;
                                                    for (int i = 0;
                                                        i <
                                                            transactionList
                                                                .length;
                                                        i++) {
                                                      totalPayed =
                                                          transactionList[i]
                                                                  .amountPayed +
                                                              totalPayed;
                                                    }
                                                    double yetToPay = 0;

                                                    Provider.of<OrderProvider>(
                                                            context,
                                                            listen: false)
                                                        .getSpecificRetailerOrdersDataList(
                                                            shopID: data['id'],
                                                            email: data[
                                                                    'assignedto']
                                                                .first)
                                                        .then((_) {
                                                      var ordersList = Provider
                                                              .of<OrderProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .allOrdermodelforSpecificRetailer;

                                                      for (int ii = 0;
                                                          ii <
                                                              ordersList.length;
                                                          ii++) {
                                                        yetToPay = ordersList[
                                                                    ii]
                                                                .grandtotal +
                                                            yetToPay;
                                                      }

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  balance_Screen(
                                                                    shopId: data[
                                                                        'id'],
                                                                    email: data[
                                                                            'assignedto']
                                                                        .first,
                                                                    yetToPay:
                                                                        yetToPay,
                                                                    payed:
                                                                        totalPayed,
                                                                  )));
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.purple
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'Balance Details',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.purple,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Shop Location',
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.5,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.5,
                                                            child:
                                                                LiveLocationMap(
                                                              markers: {
                                                                Marker(
                                                                  markerId:
                                                                      const MarkerId(
                                                                          'Shop Location'),
                                                                  position: LatLng(
                                                                      data['latlong']
                                                                          .latitude,
                                                                      data['latlong']
                                                                          .longitude),
                                                                )
                                                              },
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          () {
                                                            var date = DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                                    data[
                                                                        'timestamp']);
                                                            return Text(
                                                              '${date.hour}:${date.minute}:${date.second}  ${date.day}-${date.month}-${date.year}',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            );
                                                          }(),
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK'),
                                                          child:
                                                              const Text('OK'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.green
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'Shop Location',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      MediaQuery.of(context).size.width > 500
                                          ? Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    MediaQuery.of(context)
                                                                .size
                                                                .width >
                                                            900
                                                        ? SizedBox(
                                                            height: 40,
                                                            width: 40,
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            EditShop(
                                                                              shopProfile: ShopsProfile(id: data[Dbkeys.id], type: data[Dbkeys.type], ownerName: data[Dbkeys.ownerName], phone: data[Dbkeys.phone], approved: data[Dbkeys.approved], typeId: data[Dbkeys.typeId], addedby: data[Dbkeys.addedby], assignedto: data[Dbkeys.assignedto], timestamp: data[Dbkeys.timestamp], url: data[Dbkeys.url], address: data[Dbkeys.address], latlong: data[Dbkeys.latlong], cnic: data[Dbkeys.cnic], company: data[Dbkeys.company], shopName: data[Dbkeys.shopName], targeted: data['targeted'], targetUpdateTime: data['targetUpdateTime'], lastVisit: data['lastVisit']),
                                                                            )));
                                                              },
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
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
                                                                      Icons
                                                                          .edit,
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
                                                          )
                                                        : Container(),
                                                    MediaQuery.of(context)
                                                                .size
                                                                .width >
                                                            900
                                                        ? const SizedBox(
                                                            height: 10,
                                                          )
                                                        : Container(),
                                                    SizedBox(
                                                      height: 40,
                                                      width: 40,
                                                      child: MaterialButton(
                                                        onPressed: () async {
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
                                                              Provider.of<ShopsProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .deleteShop(
                                                                      data[
                                                                          'id']);
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
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          10)),
                                                            ),
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
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
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        ;
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
