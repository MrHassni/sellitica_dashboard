import 'dart:developer';

import 'package:erp_aspire/screens/dashboard/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants.dart';
import '../../models/attendance_model.dart';
import 'attendance_map.dart';

class UserAttendanceScreen extends StatefulWidget {
  final List<AttendanceModel> specificUserAttendance;
  final Set<Marker> markersSet;
  final List<LatLng> pointList;
  const UserAttendanceScreen(
      {Key? key,
      required this.specificUserAttendance,
      required this.markersSet,
      required this.pointList})
      : super(key: key);

  @override
  State<UserAttendanceScreen> createState() => _UserAttendanceScreenState();
}

class _UserAttendanceScreenState extends State<UserAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.specificUserAttendance.isEmpty || widget.markersSet.isEmpty
          ? const Center(
              child: Text('No Attendance Available'),
            )
          : Card(
              margin: const EdgeInsets.all(25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Header(
                      title: 'User Attendance',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height > 750
                              ? MediaQuery.of(context).size.height * .8
                              : MediaQuery.of(context).size.height > 600
                                  ? MediaQuery.of(context).size.height * .75
                                  : MediaQuery.of(context).size.height * .65,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ListView.separated(
                            shrinkWrap: true,
                            // primary: false,
                            // itemCount: 20,
                            itemCount: widget.specificUserAttendance.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              log(MediaQuery.of(context)
                                  .size
                                  .height
                                  .toString());
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  color: Colors.white,
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  onPressed: () {},
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        child: Text(
                                          widget.specificUserAttendance[index]
                                              .shopName,
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      () {
                                        DateTime date = DateTime
                                            .fromMillisecondsSinceEpoch(widget
                                                .specificUserAttendance[index]
                                                .timeStamp);

                                        return Text.rich(TextSpan(
                                            text: 'Time ',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: primaryColor,
                                                fontWeight: FontWeight.w500),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    '${date.hour}:${date.minute}   ${date.day}-${date.month}-${date.year}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    letterSpacing: 0.5,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ]));
                                      }(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Wrap(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFFFA113)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text.rich(TextSpan(
                                                  text: 'Shop Owner ',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFFFFA113),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                      text: widget
                                                          .specificUserAttendance[
                                                              index]
                                                          .shopOwner,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          letterSpacing: 0.5,
                                                          color:
                                                              Color(0xFFFFA113),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ])),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
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
                        MediaQuery.of(context).size.width < 1100
                            ? Container()
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: AttendanceMap(
                                  markers: widget.markersSet,
                                  points: widget.pointList,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
