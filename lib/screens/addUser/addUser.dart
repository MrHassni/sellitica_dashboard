import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/models/attendance_model.dart';
import 'package:erp_aspire/provider/addRetailerProvider.dart';
import 'package:erp_aspire/provider/userProvider.dart';
import 'package:erp_aspire/screens/addUser/user_attendance_screen.dart';
import 'package:erp_aspire/screens/main/components/side_menu.dart';
import 'package:erp_aspire/screens/shops/shops_of_specific_user.dart';
import 'package:erp_aspire/widgets/regularWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants.dart';
import '../../provider/shopsProvider.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import 'live_location_map.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  void initState() {
    Provider.of<userProvider>(context, listen: false).mGetAllUsers();
    super.initState();
  }

  TextEditingController orderTargetController = TextEditingController();
  String search = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width < 1100
          ? AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Manage User/ Salesman'),
            )
          : PreferredSize(
              child: Container(), preferredSize: const Size.fromHeight(0)),
      drawer: const SideMenu(),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.all(20),
        child: SafeArea(
            child: Container(
          height: height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Consumer2<addRetailerProvider, userProvider>(
              builder:
                  (context, provider, theUserProvider, _child) =>
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            width > 1100
                                ? const Header(
                                    title: 'Manage User/ Salesman',
                                  )
                                : Container(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // SizedBox(
                                      //   height: 400,
                                      //   child: FirestoreSearchScaffold(
                                      //     firestoreCollectionName: 'users',
                                      //     searchBy: 'name',
                                      //     dataListFromSnapshot:
                                      //         theUserProvider.myUsersForSearch(),
                                      //     //     (QuerySnapshot<Object?> query) {
                                      //     //   return theUserProvider.allusers;
                                      //     // },
                                      //     builder: (context, snapshot) {
                                      //       if (snapshot.hasData) {
                                      //         final List<users_Model>?
                                      //             dataList = snapshot.data;
                                      //         if (dataList!.isEmpty) {
                                      //           return const Center(
                                      //             child: Text(
                                      //                 'No Results Returned'),
                                      //           );
                                      //         }
                                      //         return ListView.builder(
                                      //             itemCount: dataList.length,
                                      //             itemBuilder:
                                      //                 (context, index) {
                                      //               final users_Model data =
                                      //                   dataList[index];
                                      //
                                      //               return Column(
                                      //                 mainAxisSize:
                                      //                     MainAxisSize.min,
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .center,
                                      //                 crossAxisAlignment:
                                      //                     CrossAxisAlignment
                                      //                         .start,
                                      //                 children: [
                                      //                   Padding(
                                      //                     padding:
                                      //                         const EdgeInsets
                                      //                             .all(8.0),
                                      //                     child: Text(
                                      //                       data.name,
                                      //                       style: Theme.of(
                                      //                               context)
                                      //                           .textTheme
                                      //                           .headline6,
                                      //                     ),
                                      //                   ),
                                      //                   Padding(
                                      //                     padding:
                                      //                         const EdgeInsets
                                      //                                 .only(
                                      //                             bottom: 8.0,
                                      //                             left: 8.0,
                                      //                             right: 8.0),
                                      //                     child: Text(
                                      //                         data.email,
                                      //                         style: Theme.of(
                                      //                                 context)
                                      //                             .textTheme
                                      //                             .bodyText1),
                                      //                   )
                                      //                 ],
                                      //               );
                                      //             });
                                      //       }
                                      //
                                      //       if (snapshot.connectionState ==
                                      //           ConnectionState.done) {
                                      //         if (!snapshot.hasData) {
                                      //           return const Center(
                                      //             child: Text(
                                      //                 'No Results Returned'),
                                      //           );
                                      //         }
                                      //       }
                                      //       return const Center(
                                      //         child:
                                      //             CircularProgressIndicator(),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),

                                      if (Responsive.isMobile(context))
                                        Column(
                                          children: [
                                            const SizedBox(
                                                height: defaultPadding),
                                            TextFormField(
                                              controller: theUserProvider
                                                  .fullnameController,
                                              decoration: inputdecoration(
                                                  label: 'Full name'),
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            TextFormField(
                                              controller: theUserProvider
                                                  .emailController,
                                              decoration: inputdecoration(
                                                  label: 'Email'),
                                            ),
                                            const SizedBox(
                                                height: defaultPadding),
                                            TextFormField(
                                              controller: theUserProvider
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
                                                    controller: theUserProvider
                                                        .btnController,
                                                    color: primaryColor,
                                                    onPressed: () async {
                                                      if (theUserProvider
                                                              .emailController
                                                              .text
                                                              .isNotEmpty &&
                                                          theUserProvider
                                                              .fullnameController
                                                              .text
                                                              .isNotEmpty &&
                                                          theUserProvider
                                                              .passwordController
                                                              .text
                                                              .isNotEmpty) {
                                                        theUserProvider
                                                            .mUploadNewUser(
                                                                context);
                                                      } else {
                                                        theUserProvider
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
                                                          theUserProvider
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
                                      // FirestoreSearchResults.builder(
                                      //   tag: 'example',
                                      //   firestoreCollectionName: 'users',
                                      //   searchBy: 'name',
                                      //   initialBody: const Center(
                                      //     child: Text('Initial body'),
                                      //   ),
                                      //   dataListFromSnapshot:
                                      //       ,
                                      //   builder: (context, snapshot) {
                                      //     if (snapshot.hasData) {
                                      //       final List<users_Model>? dataList =
                                      //           snapshot.data;
                                      //       if (dataList!.isEmpty) {
                                      //         return const Center(
                                      //           child:
                                      //               Text('No Results Returned'),
                                      //         );
                                      //       }
                                      //       return ListView.builder(
                                      //           itemCount: dataList.length,
                                      //           itemBuilder: (context, index) {
                                      //             final users_Model data =
                                      //                 dataList[index];
                                      //
                                      //             return Column(
                                      //               mainAxisSize:
                                      //                   MainAxisSize.min,
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment
                                      //                       .center,
                                      //               crossAxisAlignment:
                                      //                   CrossAxisAlignment
                                      //                       .start,
                                      //               children: [
                                      //                 Padding(
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .all(8.0),
                                      //                   child: Text(
                                      //                     '${data.name}',
                                      //                     style:
                                      //                         Theme.of(context)
                                      //                             .textTheme
                                      //                             .headline6,
                                      //                   ),
                                      //                 ),
                                      //                 Padding(
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                               .only(
                                      //                           bottom: 8.0,
                                      //                           left: 8.0,
                                      //                           right: 8.0),
                                      //                   child: Text(
                                      //                       '${data.developer}',
                                      //                       style: Theme.of(
                                      //                               context)
                                      //                           .textTheme
                                      //                           .bodyText1),
                                      //                 )
                                      //               ],
                                      //             );
                                      //           });
                                      //     }
                                      //
                                      //     if (snapshot.connectionState ==
                                      //         ConnectionState.done) {
                                      //       if (!snapshot.hasData) {
                                      //         return const Center(
                                      //           child:
                                      //               Text('No Results Returned'),
                                      //         );
                                      //       }
                                      //     }
                                      //     return const Center(
                                      //       child: CircularProgressIndicator(),
                                      //     );
                                      //   },
                                      // ),

                                      TextField(
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.blue, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            hintText: 'Search...'),
                                        onChanged: (val) {
                                          setState(() {
                                            search = val;
                                          });
                                          theUserProvider.mGetSearchUsers(
                                              search: val);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      search == '' ||
                                              search == ' ' ||
                                              search == '  ' ||
                                              search == '   '
                                          ? ListView.separated(
                                              shrinkWrap: true,
                                              // primary: false,
                                              physics: width > 1100
                                                  ? const BouncingScrollPhysics()
                                                  : const NeverScrollableScrollPhysics(),
                                              //     NeverScrollableScrollPhysics(),

                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              // itemCount: 20,
                                              itemCount: theUserProvider
                                                  .allusers.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                List<ShopsProfile> allShops =
                                                    Provider.of<ShopsProvider>(
                                                            context,
                                                            listen: false)
                                                        .allShops;
                                                int assignedNo = 0;
                                                for (int i = 0;
                                                    i < allShops.length;
                                                    i++) {
                                                  if (allShops[i]
                                                          .assignedto
                                                          .first ==
                                                      theUserProvider
                                                          .allusers[index]
                                                          .email) {
                                                    assignedNo++;
                                                  }
                                                }

                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 0),
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    color: Colors.white,
                                                    elevation: 5,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                    onPressed: () {
                                                      Timer.periodic(
                                                          const Duration(
                                                              seconds: 15),
                                                          (Timer t) {
                                                        Provider.of<userProvider>(
                                                                context,
                                                                listen: false)
                                                            .getLiveLocation(
                                                                theUserProvider
                                                                    .allusers[
                                                                        index]
                                                                    .email);
                                                      });

                                                      Provider.of<userProvider>(
                                                              context,
                                                              listen: false)
                                                          .getLiveLocation(
                                                              theUserProvider
                                                                  .allusers[
                                                                      index]
                                                                  .email)
                                                          .then((_) {
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
                                                                  'User\'s Location',
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
                                                                            const MarkerId('Live Location'),
                                                                        position: LatLng(
                                                                            Provider.of<userProvider>(context, listen: false).liveLocations.first.latLong.latitude,
                                                                            Provider.of<userProvider>(context, listen: false).liveLocations.first.latLong.longitude),
                                                                      )
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                () {
                                                                  var date = DateTime.fromMillisecondsSinceEpoch(Provider.of<
                                                                              userProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .liveLocations
                                                                      .first
                                                                      .timeStamp);
                                                                  return Text(
                                                                    '${date.hour}:${date.minute}:${date.second}  ${date.day}-${date.month}-${date.year}',
                                                                    style: const TextStyle(
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
                                                                    const Text(
                                                                        'OK'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: Row(
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
                                                                theUserProvider
                                                                    .allusers[
                                                                        index]
                                                                    .name,
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
                                                              theUserProvider
                                                                  .allusers[
                                                                      index]
                                                                  .email,
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
                                                            width > 450
                                                                ? Wrap(
                                                                    children: [
                                                                      // Container(
                                                                      //   decoration: BoxDecoration(
                                                                      //       color: const Color(
                                                                      //               0xFFFFA113)
                                                                      //           .withOpacity(
                                                                      //               0.1),
                                                                      //       borderRadius:
                                                                      //           BorderRadius
                                                                      //               .circular(
                                                                      //                   8)),
                                                                      //   child: Padding(
                                                                      //     padding:
                                                                      //         const EdgeInsets
                                                                      //             .all(8.0),
                                                                      //     child: Text.rich(TextSpan(
                                                                      //         text:
                                                                      //             'Target Orders ',
                                                                      //         style: const TextStyle(
                                                                      //             fontSize: 12,
                                                                      //             color: Color(
                                                                      //                 0xFFFFA113),
                                                                      //             fontWeight:
                                                                      //                 FontWeight
                                                                      //                     .w500),
                                                                      //         children: <
                                                                      //             InlineSpan>[
                                                                      //           TextSpan(
                                                                      //             text: userprovider
                                                                      //                 .allusers[
                                                                      //                     index]
                                                                      //                 .targetorders
                                                                      //                 .toString(),
                                                                      //             style: const TextStyle(
                                                                      //                 fontSize:
                                                                      //                     12,
                                                                      //                 letterSpacing:
                                                                      //                     0.5,
                                                                      //                 color: Color(
                                                                      //                     0xFFFFA113),
                                                                      //                 fontWeight:
                                                                      //                     FontWeight
                                                                      //                         .bold),
                                                                      //           )
                                                                      //         ])),
                                                                      //   ),
                                                                      // ),
                                                                      // const SizedBox(
                                                                      //   width: 15,
                                                                      // ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Provider.of<ShopsProvider>(context, listen: false)
                                                                              .getShopsDataListOfSpecificUser(email: theUserProvider.allusers[index].email)
                                                                              .then((_) {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ShopsOfSpecificUser(
                                                                                        user: theUserProvider.allusers[index].name,
                                                                                        email: theUserProvider.allusers[index].email,
                                                                                      )),
                                                                            );
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Target shops ', style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: assignedNo.toString(),
                                                                                // userprovider
                                                                                //     .allusers[
                                                                                //         index]
                                                                                //     .targetshops
                                                                                //     .toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            30,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Set<Marker>
                                                                              markersList =
                                                                              {};
                                                                          List<LatLng>
                                                                              latLongList =
                                                                              [];
                                                                          Provider.of<ShopsProvider>(context, listen: false)
                                                                              .getShopsDataListOfSpecificUser(email: theUserProvider.allusers[index].email)
                                                                              .then((_) {
                                                                            Provider.of<ShopsProvider>(context, listen: false).getAttendanceOfSpecificUser(userEmail: theUserProvider.allusers[index].email).then((_) {
                                                                              List<AttendanceModel> specificUserAttendance = Provider.of<ShopsProvider>(context, listen: false).allAttendanceOfSpecificUser;
                                                                              for (int i = 0; i < specificUserAttendance.length; i++) {
                                                                                var date = DateTime.fromMillisecondsSinceEpoch(specificUserAttendance[i].timeStamp);
                                                                                markersList.addLabelMarker(LabelMarker(
                                                                                  textStyle: const TextStyle(fontSize: 11, color: Colors.white),
                                                                                  markerId: MarkerId('Attendance$i'),
                                                                                  position: LatLng(specificUserAttendance[i].location.latitude, specificUserAttendance[i].location.longitude),
                                                                                  draggable: false,
                                                                                  label: '${date.hour}:${date.minute}  ${date.day}-${date.month}-${date.year}',
                                                                                ));
                                                                                latLongList.add(LatLng(specificUserAttendance[i].location.latitude, specificUserAttendance[i].location.longitude));
                                                                              }
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserAttendanceScreen(markersSet: markersList, specificUserAttendance: specificUserAttendance, pointList: latLongList)));
                                                                            });
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.brown.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'Attendance Detail',
                                                                              style: TextStyle(fontSize: 12, color: Colors.brown, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            30,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showDialog<
                                                                              String>(
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                AlertDialog(
                                                                              title: const Text('Order Target'),
                                                                              content: TextFormField(
                                                                                controller: orderTargetController,
                                                                                decoration: inputdecoration(label: 'Order Target'),
                                                                              ),
                                                                              actions: <Widget>[
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                                  child: const Text('Cancel'),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    theUserProvider.updateOrderTarget(email: theUserProvider.allusers[index].email, target: int.parse(orderTargetController.text));
                                                                                    theUserProvider.mGetAllUsers().then((_) {
                                                                                      Navigator.pop(context);
                                                                                    });
                                                                                  },
                                                                                  child: const Text('Save'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.green.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text.rich(TextSpan(text: 'Order Target ', style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                                  TextSpan(
                                                                                    text: theUserProvider.allusers[index].targetorders.toString() + ' ',
                                                                                    style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: Colors.green, fontWeight: FontWeight.bold),
                                                                                  )
                                                                                ])),
                                                                                const Icon(
                                                                                  Icons.edit,
                                                                                  size: 15,
                                                                                  color: Colors.green,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Provider.of<ShopsProvider>(context, listen: false)
                                                                              .getShopsDataListOfSpecificUser(email: theUserProvider.allusers[index].email)
                                                                              .then((_) {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ShopsOfSpecificUser(
                                                                                        user: theUserProvider.allusers[index].name,
                                                                                        email: theUserProvider.allusers[index].email,
                                                                                      )),
                                                                            );
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Target shops ', style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: assignedNo.toString(),
                                                                                // userprovider
                                                                                //     .allusers[
                                                                                //         index]
                                                                                //     .targetshops
                                                                                //     .toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
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
                                                                          Set<Marker>
                                                                              markersList =
                                                                              {};
                                                                          List<LatLng>
                                                                              latLongList =
                                                                              [];
                                                                          Provider.of<ShopsProvider>(context, listen: false)
                                                                              .getAttendanceOfSpecificUser(userEmail: theUserProvider.allusers[index].email)
                                                                              .then((_) {
                                                                            List<AttendanceModel>
                                                                                specificUserAttendance =
                                                                                Provider.of<ShopsProvider>(context, listen: false).allAttendanceOfSpecificUser;
                                                                            for (int i = 0;
                                                                                i < specificUserAttendance.length;
                                                                                i++) {
                                                                              var date = DateTime.fromMillisecondsSinceEpoch(specificUserAttendance[i].timeStamp);
                                                                              markersList.addLabelMarker(LabelMarker(
                                                                                textStyle: const TextStyle(fontSize: 11, color: Colors.white),
                                                                                markerId: MarkerId('Attendance$i'),
                                                                                position: LatLng(specificUserAttendance[i].location.latitude, specificUserAttendance[i].location.longitude),
                                                                                draggable: false,
                                                                                label: '${date.hour}:${date.minute}  ${date.day}-${date.month}-${date.year}',
                                                                              ));
                                                                              latLongList.add(LatLng(specificUserAttendance[i].location.latitude, specificUserAttendance[i].location.longitude));
                                                                            }
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => UserAttendanceScreen(markersSet: markersList, specificUserAttendance: specificUserAttendance, pointList: latLongList)));
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.brown.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'Attendance Detail',
                                                                              style: TextStyle(fontSize: 12, color: Colors.brown, fontWeight: FontWeight.w500),
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
                                                                          showDialog<
                                                                              String>(
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                AlertDialog(
                                                                              title: const Text('Order Target'),
                                                                              content: TextFormField(
                                                                                controller: orderTargetController,
                                                                                decoration: inputdecoration(label: 'Order Target'),
                                                                              ),
                                                                              actions: <Widget>[
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                                  child: const Text('Cancel'),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    theUserProvider.updateOrderTarget(email: theUserProvider.allusers[index].email, target: int.parse(orderTargetController.text));
                                                                                    theUserProvider.mGetAllUsers().then((_) {
                                                                                      Navigator.pop(context);
                                                                                    });
                                                                                  },
                                                                                  child: const Text('Save'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                const Text(
                                                                                  'Target shops ',
                                                                                  style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                Text(
                                                                                  assignedNo.toString(),
                                                                                  style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                const Icon(Icons.edit)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ],
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
                                                                  print(theUserProvider
                                                                      .allusers[
                                                                          index]
                                                                      .id);

                                                                  theUserProvider.mDeleteUsers(
                                                                      theUserProvider
                                                                          .allusers[
                                                                              index]
                                                                          .id,
                                                                      theUserProvider
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
                                                        )
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
                                            )
                                          : ListView.separated(
                                              shrinkWrap: true,
                                              physics: width > 1100
                                                  ? const BouncingScrollPhysics()
                                                  : const NeverScrollableScrollPhysics(),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              itemCount: theUserProvider
                                                  .searchedUsers.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                List<ShopsProfile> allShops =
                                                    Provider.of<ShopsProvider>(
                                                            context,
                                                            listen: false)
                                                        .allShops;
                                                int assignedNo = 0;
                                                for (int i = 0;
                                                    i < allShops.length;
                                                    i++) {
                                                  if (allShops[i]
                                                          .assignedto
                                                          .first ==
                                                      theUserProvider
                                                          .searchedUsers[index]
                                                          .email) {
                                                    assignedNo++;
                                                  }
                                                }

                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 0),
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    color: Colors.white,
                                                    elevation: 5,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                    onPressed: () {
                                                      Timer.periodic(
                                                          const Duration(
                                                              seconds: 15),
                                                          (Timer t) {
                                                        Provider.of<userProvider>(
                                                                context,
                                                                listen: false)
                                                            .getLiveLocation(
                                                                theUserProvider
                                                                    .searchedUsers[
                                                                        index]
                                                                    .email);
                                                      });

                                                      Provider.of<userProvider>(
                                                              context,
                                                              listen: false)
                                                          .getLiveLocation(
                                                              theUserProvider
                                                                  .searchedUsers[
                                                                      index]
                                                                  .email)
                                                          .then((_) {
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
                                                                  'User\'s Location',
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
                                                                            const MarkerId('Live Location'),
                                                                        position: LatLng(
                                                                            Provider.of<userProvider>(context, listen: false).liveLocations.first.latLong.latitude,
                                                                            Provider.of<userProvider>(context, listen: false).liveLocations.first.latLong.longitude),
                                                                      )
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                () {
                                                                  var date = DateTime.fromMillisecondsSinceEpoch(Provider.of<
                                                                              userProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .liveLocations
                                                                      .first
                                                                      .timeStamp);
                                                                  return Text(
                                                                    '${date.hour}:${date.minute}:${date.second}  ${date.day}-${date.month}-${date.year}',
                                                                    style: const TextStyle(
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
                                                                    const Text(
                                                                        'OK'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: Row(
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
                                                                theUserProvider
                                                                    .searchedUsers[
                                                                        index]
                                                                    .name,
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
                                                              theUserProvider
                                                                  .searchedUsers[
                                                                      index]
                                                                  .email,
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
                                                            width > 450
                                                                ? Wrap(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Provider.of<ShopsProvider>(context, listen: false)
                                                                              .getShopsDataListOfSpecificUser(email: theUserProvider.searchedUsers[index].email)
                                                                              .then((_) {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ShopsOfSpecificUser(
                                                                                        user: theUserProvider.searchedUsers[index].name,
                                                                                        email: theUserProvider.searchedUsers[index].email,
                                                                                      )),
                                                                            );
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Target shops ', style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: assignedNo.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            30,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Set<Marker>
                                                                              markersList =
                                                                              {};
                                                                          List<LatLng>
                                                                              latLongList =
                                                                              [];
                                                                          Provider.of<ShopsProvider>(context, listen: false)
                                                                              .getShopsDataListOfSpecificUser(email: theUserProvider.searchedUsers[index].email)
                                                                              .then((_) {
                                                                            Provider.of<ShopsProvider>(context, listen: false).getAttendanceOfSpecificUser(userEmail: theUserProvider.searchedUsers[index].email).then((_) {
                                                                              List<AttendanceModel> specificUserAttendance = Provider.of<ShopsProvider>(context, listen: false).allAttendanceOfSpecificUser;
                                                                              for (int i = 0; i < specificUserAttendance.length; i++) {
                                                                                var date = DateTime.fromMillisecondsSinceEpoch(specificUserAttendance[i].timeStamp);
                                                                                markersList.addLabelMarker(LabelMarker(
                                                                                  textStyle: const TextStyle(fontSize: 11, color: Colors.white),
                                                                                  markerId: MarkerId('Attendance$i'),
                                                                                  position: LatLng(specificUserAttendance[i].location.latitude, specificUserAttendance[i].location.longitude),
                                                                                  draggable: false,
                                                                                  label: '${date.hour}:${date.minute}  ${date.day}-${date.month}-${date.year}',
                                                                                ));
                                                                                latLongList.add(LatLng(specificUserAttendance[i].location.latitude, specificUserAttendance[i].location.longitude));
                                                                              }
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserAttendanceScreen(markersSet: markersList, specificUserAttendance: specificUserAttendance, pointList: latLongList)));
                                                                            });
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.brown.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'Attendance Detail',
                                                                              style: TextStyle(fontSize: 12, color: Colors.brown, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            30,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showDialog<
                                                                              String>(
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                AlertDialog(
                                                                              title: const Text('Order Target'),
                                                                              content: TextFormField(
                                                                                controller: orderTargetController,
                                                                                decoration: inputdecoration(label: 'Order Target'),
                                                                              ),
                                                                              actions: <Widget>[
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                                  child: const Text('Cancel'),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    theUserProvider.updateOrderTarget(email: theUserProvider.searchedUsers[index].email, target: int.parse(orderTargetController.text));
                                                                                    theUserProvider.mGetAllUsers().then((_) {
                                                                                      Navigator.pop(context);
                                                                                    });
                                                                                  },
                                                                                  child: const Text('Save'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.green.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text.rich(TextSpan(text: 'Order Target ', style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                                  TextSpan(
                                                                                    text: theUserProvider.searchedUsers[index].targetorders.toString() + ' ',
                                                                                    style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: Colors.green, fontWeight: FontWeight.bold),
                                                                                  )
                                                                                ])),
                                                                                const Icon(
                                                                                  Icons.edit,
                                                                                  size: 15,
                                                                                  color: Colors.green,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Provider.of<ShopsProvider>(context, listen: false)
                                                                              .getShopsDataListOfSpecificUser(email: theUserProvider.searchedUsers[index].email)
                                                                              .then((_) {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ShopsOfSpecificUser(
                                                                                        user: theUserProvider.searchedUsers[index].name,
                                                                                        email: theUserProvider.searchedUsers[index].email,
                                                                                      )),
                                                                            );
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: primaryColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text.rich(TextSpan(text: 'Target shops ', style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500), children: <InlineSpan>[
                                                                              TextSpan(
                                                                                text: assignedNo.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                              )
                                                                            ])),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Set<Marker>
                                                                              markersList =
                                                                              {};
                                                                          List<LatLng>
                                                                              latLongList =
                                                                              [];
                                                                          Provider.of<ShopsProvider>(context, listen: false)
                                                                              .getAttendanceOfSpecificUser(userEmail: theUserProvider.searchedUsers[index].email)
                                                                              .then((_) {
                                                                            List<AttendanceModel>
                                                                                specificUserAttendance =
                                                                                Provider.of<ShopsProvider>(context, listen: false).allAttendanceOfSpecificUser;
                                                                            for (int i = 0;
                                                                                i < specificUserAttendance.length;
                                                                                i++) {
                                                                              var date = DateTime.fromMillisecondsSinceEpoch(specificUserAttendance[i].timeStamp);
                                                                              markersList.addLabelMarker(LabelMarker(
                                                                                textStyle: const TextStyle(fontSize: 11, color: Colors.white),
                                                                                markerId: MarkerId('Attendance$i'),
                                                                                position: LatLng(specificUserAttendance[i].location.latitude, specificUserAttendance[i].location.longitude),
                                                                                draggable: false,
                                                                                label: '${date.hour}:${date.minute}  ${date.day}-${date.month}-${date.year}',
                                                                              ));
                                                                              latLongList.add(LatLng(specificUserAttendance[i].location.latitude, specificUserAttendance[i].location.longitude));
                                                                            }
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => UserAttendanceScreen(markersSet: markersList, specificUserAttendance: specificUserAttendance, pointList: latLongList)));
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.brown.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(8)),
                                                                          child:
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'Attendance Detail',
                                                                              style: TextStyle(fontSize: 12, color: Colors.brown, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                primaryColor.withOpacity(0.1),
                                                                            borderRadius: BorderRadius.circular(8)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              const Text(
                                                                                'Target shops ',
                                                                                style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500),
                                                                              ),
                                                                              Text(
                                                                                assignedNo.toString(),
                                                                                style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              const Icon(Icons.edit)
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ],
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
                                                                  print(theUserProvider
                                                                      .searchedUsers[
                                                                          index]
                                                                      .id);

                                                                  theUserProvider.mDeleteUsers(
                                                                      theUserProvider
                                                                          .searchedUsers[
                                                                              index]
                                                                          .id,
                                                                      theUserProvider
                                                                          .searchedUsers[
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
                                                                )),
                                                          ),
                                                        )
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                controller: theUserProvider
                                                    .fullnameController,
                                                decoration: inputdecoration(
                                                    label: 'Full name'),
                                              ),
                                              const SizedBox(
                                                  height: defaultPadding),
                                              TextFormField(
                                                controller: theUserProvider
                                                    .emailController,
                                                decoration: inputdecoration(
                                                    label: 'Email'),
                                              ),
                                              const SizedBox(
                                                  height: defaultPadding),
                                              TextFormField(
                                                controller: theUserProvider
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
                                                      controller:
                                                          theUserProvider
                                                              .btnController,
                                                      color: primaryColor,
                                                      onPressed: () async {
                                                        if (theUserProvider.emailController.text.isNotEmpty &&
                                                            theUserProvider
                                                                .fullnameController
                                                                .text
                                                                .isNotEmpty &&
                                                            theUserProvider
                                                                .passwordController
                                                                .text
                                                                .isNotEmpty) {
                                                          theUserProvider
                                                              .mUploadNewUser(
                                                                  context);
                                                        } else {
                                                          theUserProvider
                                                              .btnController
                                                              .error();
                                                          mShowNotificationError(
                                                              heading:
                                                                  "Warning",
                                                              context: context,
                                                              message:
                                                                  "Please fill all required fields");
                                                          Timer(
                                                              const Duration(
                                                                  milliseconds:
                                                                      500), () {
                                                            theUserProvider
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
        )),
      ),
    );
  }
}
