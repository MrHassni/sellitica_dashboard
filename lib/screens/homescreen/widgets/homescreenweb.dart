import 'package:erp_aspire/Utils/appConstants.dart';
import 'package:erp_aspire/provider/screenResponsiveProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class homescreenweb extends StatefulWidget {
  const homescreenweb({Key? key}) : super(key: key);

  @override
  _homescreenwebState createState() => _homescreenwebState();
}

class _homescreenwebState extends State<homescreenweb> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer<screenResponsiveProvider>(
        builder: (context, provider, _child) {
      return Scaffold(
        // backgroundColor: txtColor,
        body: Row(
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors
                    .white, //This will change the drawer background to blue.
                //other styles
              ),
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    const DrawerHeader(
                      margin: EdgeInsets.zero,
                      child: Center(child: Icon(Icons.image)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_city),
                      title: const Text('Partner'),
                      onTap: () {
                        // _setPage(ClientPage());
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.multiline_chart),
                      title: Text('Proyek'),
                      onTap: () {
                        // _setPage(ProyekPage());
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: Container(
                  color: greyLight200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: txtColor,
                        height: 100,
                        width: constraints.maxWidth,
                        child: Row(
                          children: [
                            // MaterialButton(
                            //   onPressed: () {},
                            //   child: Text("Sign Up"),
                            // )
                            // Material(
                            //   child: InkWell(
                            //     onTap: () {},
                            //     onHover: (value) {
                            //       // provider.monHover(val: value, context: context);
                            //       Tooltip(
                            //         message: "message",
                            //         child: Container(
                            //           width: 100,
                            //           height: 100,
                            //           color: Colors.blue,
                            //         ),
                            //       );
                            //     },
                            //     child: Row(
                            //       children: [
                            //         Icon(Icons.my_library_add_outlined),
                            //         Text(
                            //           'Discover',
                            //           style: TextStyle(color: Colors.black),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 10, top: 10, bottom: 20),
                            color: txtColor,
                            height: 300,
                            width: constraints.maxWidth / 1.69,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 20, top: 10, bottom: 20),
                            color: txtColor,
                            height: 300,
                            width: constraints.maxWidth / 3.45,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 10, top: 20, bottom: 10),
                            color: txtColor,
                            height: 300,
                            width: constraints.maxWidth / 3.45,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 10),
                            color: txtColor,
                            height: 300,
                            width: constraints.maxWidth / 3.45,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 20, top: 20, bottom: 10),
                            color: txtColor,
                            height: 300,
                            width: constraints.maxWidth / 3.45,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 10, top: 10, bottom: 20),
                            color: txtColor,
                            height: 300,
                            width: constraints.maxWidth / 3.45,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 20, top: 10, bottom: 20),
                            color: txtColor,
                            height: 300,
                            width: constraints.maxWidth / 1.69,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })),
          ],
        ),
      );
    });
  }
}
