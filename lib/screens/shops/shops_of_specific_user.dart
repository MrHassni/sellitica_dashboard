import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:erp_aspire/screens/addShop/edit_shop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Provider/money_provider.dart';
import '../../constants.dart';
import '../../provider/order_provider.dart';
import '../../provider/shopsProvider.dart';
import '../../responsive.dart';
import '../addUser/live_location_map.dart';
import '../balance_screen/balance_screen.dart';
import '../dashboard/components/header.dart';
import '../dashboard/components/storage_info_card.dart';

class ShopsOfSpecificUser extends StatefulWidget {
  final String user;
  final String email;
  const ShopsOfSpecificUser({Key? key, required this.user, required this.email})
      : super(key: key);

  @override
  _ShopsOfSpecificUserState createState() => _ShopsOfSpecificUserState();
}

class _ShopsOfSpecificUserState extends State<ShopsOfSpecificUser> {
  List<bool> value = [];
  String search = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        height: height,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Consumer<ShopsProvider>(
            builder: (context, provider, _child) => Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        title: widget.user + ' Shops',
                      ),
                      const SizedBox(height: defaultPadding),
                      ///////FORM WIDTH WILL BE FULL IN MOBILE VIEW AND HALF IN THE DESKTOP VIEW
                      // .
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
                                TextField(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue, width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      prefixIcon: const Icon(Icons.search),
                                      hintText: 'Search...'),
                                  onChanged: (val) {
                                    setState(() {
                                      search = val;
                                    });
                                    provider.searchShopsDataListOfSpecificUser(
                                        email: widget.email, search: val);
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                search == '' ||
                                        search == ' ' ||
                                        search == '  ' ||
                                        search == '   '
                                    ? SizedBox(
                                        height: height - 200,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          primary: false,
                                          // physics:
                                          //     NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          // itemCount: 20,
                                          itemCount: provider
                                              .allShopsListOfSpecificUser
                                              .length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            value.add(false);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 0),
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
                                                  provider.mUpdateSelectedShop(
                                                      provider.allShopsListOfSpecificUser[
                                                          index]);
                                                  provider.allAttendance
                                                      .clear();
                                                  provider.getShopAttendance();
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        provider
                                                                .allShopsListOfSpecificUser[
                                                                    index]
                                                                .targeted!
                                                            ? () {
                                                                var dt = DateTime
                                                                    .fromMillisecondsSinceEpoch(provider
                                                                        .allShopsListOfSpecificUser[
                                                                            index]
                                                                        .targetUpdateTime!);
                                                                return Text(
                                                                    '${dt.day}-${dt.month}-${dt.year}');
                                                              }()
                                                            : Container(),
                                                        provider
                                                                    .allShopsListOfSpecificUser[
                                                                        index]
                                                                    .targeted ==
                                                                null
                                                            ? Container()
                                                            : Switch(
                                                                activeColor:
                                                                    Colors
                                                                        .purple
                                                                        .shade200,
                                                                value: provider
                                                                    .allShopsListOfSpecificUser[
                                                                        index]
                                                                    .targeted!,
                                                                onChanged:
                                                                    (val) {
                                                                  provider
                                                                      .updateTargetedShops(
                                                                          shopId: provider
                                                                              .allShopsListOfSpecificUser[
                                                                                  index]
                                                                              .id,
                                                                          targeted:
                                                                              val)
                                                                      .then(
                                                                          (_) {
                                                                    provider.getShopsDataListOfSpecificUser(
                                                                        email: provider
                                                                            .allShopsListOfSpecificUser[index]
                                                                            .assignedto[0]);
                                                                  });
                                                                },
                                                              ),
                                                        provider
                                                                .allShopsListOfSpecificUser[
                                                                    index]
                                                                .targeted!
                                                            ? () {
                                                                var dt = DateTime.fromMillisecondsSinceEpoch((provider
                                                                        .allShopsListOfSpecificUser[
                                                                            index]
                                                                        .targetUpdateTime!) +
                                                                    604800000);
                                                                return Text(
                                                                    '${dt.day}-${dt.month}-${dt.year}');
                                                              }()
                                                            : Container(),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),

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
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                child: Text(
                                                                  provider
                                                                      .allShopsListOfSpecificUser[
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
                                                                height: 10,
                                                              ),
                                                              width < 660
                                                                  ? Column(
                                                                      children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: const Color(0xFFFFA113).withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Owner: ', style: const TextStyle(fontSize: 12, color: Color(0xFFFFA113), fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: provider.allShopsListOfSpecificUser[index].ownerName.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: Color(0xFFFFA113), fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Phone No. ', style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: provider.allShopsListOfSpecificUser[index].phone.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
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
                                                                              color: const Color(0xFFFFA113).withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Owner: ', style: const TextStyle(fontSize: 12, color: Color(0xFFFFA113), fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: provider.allShopsListOfSpecificUser[index].ownerName.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: Color(0xFFFFA113), fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Phone No. ', style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: provider.allShopsListOfSpecificUser[index].phone.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              width < 660
                                                                  ? Column(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Provider.of<MoneyProvider>(context, listen: false).getAllTransactions(provider.allShopsListOfSpecificUser[index].id).then((_) {
                                                                              double totalPayed = 0;
                                                                              var transactionList = Provider.of<MoneyProvider>(context, listen: false).allTransactions;
                                                                              for (int i = 0; i < transactionList.length; i++) {
                                                                                totalPayed = transactionList[i].amountPayed + totalPayed;
                                                                              }
                                                                              double yetToPay = 0;

                                                                              Provider.of<OrderProvider>(context, listen: false).getSpecificRetailerOrdersDataList(shopID: provider.allShopsListOfSpecificUser[index].id, email: provider.allShopsListOfSpecificUser[index].assignedto.first).then((_) {
                                                                                var ordersList = Provider.of<OrderProvider>(context, listen: false).allOrdermodelforSpecificRetailer;

                                                                                for (int ii = 0; ii < ordersList.length; ii++) {
                                                                                  yetToPay = ordersList[ii].grandtotal + yetToPay;
                                                                                }

                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => balance_Screen(
                                                                                              shopId: provider.allShopsListOfSpecificUser[index].id,
                                                                                              email: provider.allShopsListOfSpecificUser[index].assignedto.first,
                                                                                              yetToPay: yetToPay,
                                                                                              payed: totalPayed,
                                                                                            )));
                                                                              });
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Balance Details',
                                                                                style: TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            showDialog<String>(
                                                                              context: context,
                                                                              builder: (BuildContext context) => AlertDialog(
                                                                                contentPadding: EdgeInsets.zero,
                                                                                title: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Shop Location',
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * 0.5,
                                                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                                                      child: LiveLocationMap(
                                                                                        markers: {
                                                                                          Marker(
                                                                                            markerId: const MarkerId('Shop Location'),
                                                                                            position: LatLng(provider.allShopsListOfSpecificUser[index].latlong.latitude, provider.allShopsListOfSpecificUser[index].latlong.longitude),
                                                                                          )
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    () {
                                                                                      var date = DateTime.fromMillisecondsSinceEpoch(provider.allShopsListOfSpecificUser[index].timestamp);
                                                                                      return Text(
                                                                                        '${date.hour}:${date.minute}:${date.second}  ${date.day}-${date.month}-${date.year}',
                                                                                        style: const TextStyle(fontSize: 12),
                                                                                      );
                                                                                    }(),
                                                                                  ],
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(context, 'OK'),
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Shop Location',
                                                                                style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Wrap(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Provider.of<MoneyProvider>(context, listen: false).getAllTransactions(provider.allShopsListOfSpecificUser[index].id).then((_) {
                                                                              double totalPayed = 0;
                                                                              var transactionList = Provider.of<MoneyProvider>(context, listen: false).allTransactions;
                                                                              for (int i = 0; i < transactionList.length; i++) {
                                                                                totalPayed = transactionList[i].amountPayed + totalPayed;
                                                                              }
                                                                              double yetToPay = 0;

                                                                              Provider.of<OrderProvider>(context, listen: false).getSpecificRetailerOrdersDataList(shopID: provider.allShopsListOfSpecificUser[index].id, email: provider.allShopsListOfSpecificUser[index].assignedto.first).then((_) {
                                                                                var ordersList = Provider.of<OrderProvider>(context, listen: false).allOrdermodelforSpecificRetailer;

                                                                                for (int ii = 0; ii < ordersList.length; ii++) {
                                                                                  yetToPay = ordersList[ii].grandtotal + yetToPay;
                                                                                }

                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => balance_Screen(
                                                                                              shopId: provider.allShopsListOfSpecificUser[index].id,
                                                                                              email: provider.allShopsListOfSpecificUser[index].assignedto.first,
                                                                                              yetToPay: yetToPay,
                                                                                              payed: totalPayed,
                                                                                            )));
                                                                              });
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Balance Details',
                                                                                style: TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            showDialog<String>(
                                                                              context: context,
                                                                              builder: (BuildContext context) => AlertDialog(
                                                                                contentPadding: EdgeInsets.zero,
                                                                                title: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Shop Location',
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * 0.5,
                                                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                                                      child: LiveLocationMap(
                                                                                        markers: {
                                                                                          Marker(
                                                                                            markerId: const MarkerId('Shop Location'),
                                                                                            position: LatLng(provider.allShopsListOfSpecificUser[index].latlong.latitude, provider.allShopsListOfSpecificUser[index].latlong.longitude),
                                                                                          )
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    () {
                                                                                      var date = DateTime.fromMillisecondsSinceEpoch(provider.allShopsListOfSpecificUser[index].timestamp);
                                                                                      return Text(
                                                                                        '${date.hour}:${date.minute}:${date.second}  ${date.day}-${date.month}-${date.year}',
                                                                                        style: const TextStyle(fontSize: 12),
                                                                                      );
                                                                                    }(),
                                                                                  ],
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(context, 'OK'),
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Shop Location',
                                                                                style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                            ],
                                                          ),
                                                          width < 660
                                                              ? Container()
                                                              : Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              MaterialButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => EditShop(
                                                                                            shopProfile: provider.allShopsListOfSpecificUser[index],
                                                                                          )));
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            child: Container(
                                                                                // padding: EdgeInsets.all(
                                                                                //     defaultPadding *
                                                                                //         0.75),

                                                                                height: 40,
                                                                                width: 40,
                                                                                decoration: BoxDecoration(
                                                                                  color: primaryColor.withOpacity(0.1),
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                ),
                                                                                child: const Center(
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                    color: primaryColor,
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
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              MaterialButton(
                                                                            onPressed:
                                                                                () async {
                                                                              final response = await showOkCancelAlertDialog(context: context, title: "Are you sure!", message: "You want to delete this user.?");
                                                                              if (response.toString() == "OkCancelResult.ok") {
                                                                                if (kDebugMode) {
                                                                                  provider.deleteShop(provider.allShopsListOfSpecificUser[index].id);
                                                                                }
                                                                              }
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            child: Container(
                                                                                // padding: EdgeInsets.all(
                                                                                //     defaultPadding *
                                                                                //         0.75),

                                                                                height: 40,
                                                                                width: 40,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.red.withOpacity(0.1),
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                ),
                                                                                child: const Center(
                                                                                  child: Icon(
                                                                                    Icons.delete,
                                                                                    color: Colors.red,
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
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const SizedBox(
                                              width: 20,
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox(
                                        height: height - 200,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          primary: false,
                                          // physics:
                                          //     NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          // itemCount: 20,
                                          itemCount: provider
                                              .searchShopsListOfSpecificUser
                                              .length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            value.add(false);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 0),
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
                                                  provider.mUpdateSelectedShop(
                                                      provider.searchShopsListOfSpecificUser[
                                                          index]);
                                                  provider.allAttendance
                                                      .clear();
                                                  provider.getShopAttendance();
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        provider
                                                                .searchShopsListOfSpecificUser[
                                                                    index]
                                                                .targeted!
                                                            ? () {
                                                                var dt = DateTime
                                                                    .fromMillisecondsSinceEpoch(provider
                                                                        .searchShopsListOfSpecificUser[
                                                                            index]
                                                                        .targetUpdateTime!);
                                                                return Text(
                                                                    '${dt.day}-${dt.month}-${dt.year}');
                                                              }()
                                                            : Container(),
                                                        provider
                                                                    .searchShopsListOfSpecificUser[
                                                                        index]
                                                                    .targeted ==
                                                                null
                                                            ? Container()
                                                            : Switch(
                                                                activeColor:
                                                                    Colors
                                                                        .purple
                                                                        .shade200,
                                                                value: provider
                                                                    .searchShopsListOfSpecificUser[
                                                                        index]
                                                                    .targeted!,
                                                                onChanged:
                                                                    (val) {
                                                                  provider
                                                                      .updateTargetedShops(
                                                                          shopId: provider
                                                                              .searchShopsListOfSpecificUser[
                                                                                  index]
                                                                              .id,
                                                                          targeted:
                                                                              val)
                                                                      .then(
                                                                          (_) {
                                                                    provider.getShopsDataListOfSpecificUser(
                                                                        email: provider
                                                                            .searchShopsListOfSpecificUser[index]
                                                                            .assignedto[0]);
                                                                  });
                                                                },
                                                              ),
                                                        provider
                                                                .searchShopsListOfSpecificUser[
                                                                    index]
                                                                .targeted!
                                                            ? () {
                                                                var dt = DateTime.fromMillisecondsSinceEpoch((provider
                                                                        .searchShopsListOfSpecificUser[
                                                                            index]
                                                                        .targetUpdateTime!) +
                                                                    604800000);
                                                                return Text(
                                                                    '${dt.day}-${dt.month}-${dt.year}');
                                                              }()
                                                            : Container(),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
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
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                child: Text(
                                                                  provider
                                                                      .searchShopsListOfSpecificUser[
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
                                                                height: 10,
                                                              ),
                                                              width < 660
                                                                  ? Column(
                                                                      children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: const Color(0xFFFFA113).withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Owner: ', style: const TextStyle(fontSize: 12, color: Color(0xFFFFA113), fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: provider.searchShopsListOfSpecificUser[index].ownerName.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: Color(0xFFFFA113), fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Phone No. ', style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: provider.searchShopsListOfSpecificUser[index].phone.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
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
                                                                              color: const Color(0xFFFFA113).withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Owner: ', style: const TextStyle(fontSize: 12, color: Color(0xFFFFA113), fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: provider.searchShopsListOfSpecificUser[index].ownerName.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: Color(0xFFFFA113), fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Phone No. ', style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: provider.searchShopsListOfSpecificUser[index].phone.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              width < 660
                                                                  ? Column(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Provider.of<MoneyProvider>(context, listen: false).getAllTransactions(provider.searchShopsListOfSpecificUser[index].id).then((_) {
                                                                              double totalPayed = 0;
                                                                              var transactionList = Provider.of<MoneyProvider>(context, listen: false).allTransactions;
                                                                              for (int i = 0; i < transactionList.length; i++) {
                                                                                totalPayed = transactionList[i].amountPayed + totalPayed;
                                                                              }
                                                                              double yetToPay = 0;

                                                                              Provider.of<OrderProvider>(context, listen: false).getSpecificRetailerOrdersDataList(shopID: provider.searchShopsListOfSpecificUser[index].id, email: provider.searchShopsListOfSpecificUser[index].assignedto.first).then((_) {
                                                                                var ordersList = Provider.of<OrderProvider>(context, listen: false).allOrdermodelforSpecificRetailer;

                                                                                for (int ii = 0; ii < ordersList.length; ii++) {
                                                                                  yetToPay = ordersList[ii].grandtotal + yetToPay;
                                                                                }

                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => balance_Screen(
                                                                                              shopId: provider.searchShopsListOfSpecificUser[index].id,
                                                                                              email: provider.searchShopsListOfSpecificUser[index].assignedto.first,
                                                                                              yetToPay: yetToPay,
                                                                                              payed: totalPayed,
                                                                                            )));
                                                                              });
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Balance Details',
                                                                                style: TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            showDialog<String>(
                                                                              context: context,
                                                                              builder: (BuildContext context) => AlertDialog(
                                                                                contentPadding: EdgeInsets.zero,
                                                                                title: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Shop Location',
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * 0.5,
                                                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                                                      child: LiveLocationMap(
                                                                                        markers: {
                                                                                          Marker(
                                                                                            markerId: const MarkerId('Shop Location'),
                                                                                            position: LatLng(provider.searchShopsListOfSpecificUser[index].latlong.latitude, provider.searchShopsListOfSpecificUser[index].latlong.longitude),
                                                                                          )
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    () {
                                                                                      var date = DateTime.fromMillisecondsSinceEpoch(provider.searchShopsListOfSpecificUser[index].timestamp);
                                                                                      return Text(
                                                                                        '${date.hour}:${date.minute}:${date.second}  ${date.day}-${date.month}-${date.year}',
                                                                                        style: const TextStyle(fontSize: 12),
                                                                                      );
                                                                                    }(),
                                                                                  ],
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(context, 'OK'),
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Shop Location',
                                                                                style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Wrap(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Provider.of<MoneyProvider>(context, listen: false).getAllTransactions(provider.searchShopsListOfSpecificUser[index].id).then((_) {
                                                                              double totalPayed = 0;
                                                                              var transactionList = Provider.of<MoneyProvider>(context, listen: false).allTransactions;
                                                                              for (int i = 0; i < transactionList.length; i++) {
                                                                                totalPayed = transactionList[i].amountPayed + totalPayed;
                                                                              }
                                                                              double yetToPay = 0;

                                                                              Provider.of<OrderProvider>(context, listen: false).getSpecificRetailerOrdersDataList(shopID: provider.searchShopsListOfSpecificUser[index].id, email: provider.searchShopsListOfSpecificUser[index].assignedto.first).then((_) {
                                                                                var ordersList = Provider.of<OrderProvider>(context, listen: false).allOrdermodelforSpecificRetailer;

                                                                                for (int ii = 0; ii < ordersList.length; ii++) {
                                                                                  yetToPay = ordersList[ii].grandtotal + yetToPay;
                                                                                }

                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => balance_Screen(
                                                                                              shopId: provider.searchShopsListOfSpecificUser[index].id,
                                                                                              email: provider.searchShopsListOfSpecificUser[index].assignedto.first,
                                                                                              yetToPay: yetToPay,
                                                                                              payed: totalPayed,
                                                                                            )));
                                                                              });
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Balance Details',
                                                                                style: TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            showDialog<String>(
                                                                              context: context,
                                                                              builder: (BuildContext context) => AlertDialog(
                                                                                contentPadding: EdgeInsets.zero,
                                                                                title: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Shop Location',
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: MediaQuery.of(context).size.height * 0.5,
                                                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                                                      child: LiveLocationMap(
                                                                                        markers: {
                                                                                          Marker(
                                                                                            markerId: const MarkerId('Shop Location'),
                                                                                            position: LatLng(provider.searchShopsListOfSpecificUser[index].latlong.latitude, provider.searchShopsListOfSpecificUser[index].latlong.longitude),
                                                                                          )
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    () {
                                                                                      var date = DateTime.fromMillisecondsSinceEpoch(provider.searchShopsListOfSpecificUser[index].timestamp);
                                                                                      return Text(
                                                                                        '${date.hour}:${date.minute}:${date.second}  ${date.day}-${date.month}-${date.year}',
                                                                                        style: const TextStyle(fontSize: 12),
                                                                                      );
                                                                                    }(),
                                                                                  ],
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(context, 'OK'),
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'Shop Location',
                                                                                style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                            ],
                                                          ),
                                                          width < 660
                                                              ? Container()
                                                              : Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              MaterialButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => EditShop(
                                                                                            shopProfile: provider.searchShopsListOfSpecificUser[index],
                                                                                          )));
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            child: Container(
                                                                                // padding: EdgeInsets.all(
                                                                                //     defaultPadding *
                                                                                //         0.75),

                                                                                height: 40,
                                                                                width: 40,
                                                                                decoration: BoxDecoration(
                                                                                  color: primaryColor.withOpacity(0.1),
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                ),
                                                                                child: const Center(
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                    color: primaryColor,
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
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              40,
                                                                          child:
                                                                              MaterialButton(
                                                                            onPressed:
                                                                                () async {
                                                                              final response = await showOkCancelAlertDialog(context: context, title: "Are you sure!", message: "You want to delete this user.?");
                                                                              if (response.toString() == "OkCancelResult.ok") {
                                                                                if (kDebugMode) {
                                                                                  provider.deleteShop(provider.searchShopsListOfSpecificUser[index].id);
                                                                                }
                                                                              }
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            child: Container(
                                                                                // padding: EdgeInsets.all(
                                                                                //     defaultPadding *
                                                                                //         0.75),

                                                                                height: 40,
                                                                                width: 40,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.red.withOpacity(0.1),
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                ),
                                                                                child: const Center(
                                                                                  child: Icon(
                                                                                    Icons.delete,
                                                                                    color: Colors.red,
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
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
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
                                  child: provider.selectedShop == null
                                      ? const Center(
                                          child: Text("Select any shop"),
                                        )
                                      : () {
                                          return Card(
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
                                                          provider.selectedShop!
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
                                                          title: provider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : provider
                                                                  .selectedShop!
                                                                  .ownerName
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Owner",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: provider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : provider
                                                                  .selectedShop!
                                                                  .shopName
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Shop",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: provider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : provider
                                                                  .selectedShop!
                                                                  .address
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Address",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: provider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : provider
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
                                                          title: provider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : provider
                                                                  .selectedShop!
                                                                  .cnic
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Cnic",
                                                        ),
                                                        InfoCard(
                                                          svgSrc:
                                                              "assets/icons/Documents.svg",
                                                          title: provider
                                                                      .selectedShop ==
                                                                  null
                                                              ? ""
                                                              : provider
                                                                  .selectedShop!
                                                                  .phone
                                                                  .toString(),
                                                          amountOfFiles: "",
                                                          numOfFiles: "Phone",
                                                        ),
                                                        () {
                                                          String dt = '';
                                                          if (provider
                                                              .attendance
                                                              .isNotEmpty) {
                                                            DateTime dateTime =
                                                                DateTime.fromMillisecondsSinceEpoch(
                                                                    provider
                                                                        .attendance
                                                                        .last
                                                                        .timeStamp);
                                                            dt =
                                                                '${dateTime.hour}:${dateTime.minute}  ${dateTime.day}-${dateTime.month}-${dateTime.year}';
                                                          }
                                                          return InfoCard(
                                                            svgSrc:
                                                                "assets/icons/Documents.svg",
                                                            title: provider
                                                                        .selectedShop ==
                                                                    null
                                                                ? ""
                                                                : provider
                                                                        .attendance
                                                                        .isEmpty
                                                                    ? ''
                                                                    : dt,
                                                            amountOfFiles: "",
                                                            numOfFiles:
                                                                "Last Visit",
                                                          );
                                                        }(),
                                                        // InfoCard(
                                                        //   svgSrc:
                                                        //       "assets/icons/Documents.svg",
                                                        //   title: provider
                                                        //               .selectedShop ==
                                                        //           null
                                                        //       ? ""
                                                        //       : provider
                                                        //           .selectedShop!
                                                        //           .assignedToName
                                                        //           .first
                                                        //           .toString(),
                                                        //   amountOfFiles: "",
                                                        //   numOfFiles:
                                                        //       "Assigned To",
                                                        // ),
                                                        const SizedBox(
                                                            height: 15)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }()),
                            ),
                        ],
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
