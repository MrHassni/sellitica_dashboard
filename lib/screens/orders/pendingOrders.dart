import 'dart:async';
import 'dart:developer';

import 'package:erp_aspire/Configs/Enum.dart';
import 'package:erp_aspire/provider/homeProvider.dart';
import 'package:erp_aspire/provider/ordersModificationProvider.dart';
import 'package:erp_aspire/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../constants.dart';
import '../../widgets/regularWidgets.dart';

class pendingOrders extends StatefulWidget {
  pendingOrders({Key? key, required this.type}) : super(key: key);
  final int type;

  @override
  State<pendingOrders> createState() => _pendingOrdersState();
}

class _pendingOrdersState extends State<pendingOrders> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final List<PlutoColumnGroup> columnGroups = [
      PlutoColumnGroup(title: 'Qty', fields: ['qty'], expandedColumn: true),
      // PlutoColumnGroup(
      //     title: 'Product Name',
      //     fields: ['product name'],
      //     expandedColumn: true),
      // PlutoColumnGroup(
      //     title: 'Product Quantity',
      //     fields: ['product quantity'],
      //     expandedColumn: true),
      PlutoColumnGroup(
          title: 'Shop information', fields: ['name'], expandedColumn: true),
      PlutoColumnGroup(
          title: 'Status', fields: ['status'], expandedColumn: true),
      PlutoColumnGroup(
          title: 'Salesman', fields: ['addedby'], expandedColumn: true),
      // PlutoColumnGroup(title: 'Payment', fields: [
      //   'bank',
      //   'cheque',
      //   'from',
      //   'to',
      //   'method',
      //   'receive',
      //   'transaction'
      // ]),
      PlutoColumnGroup(title: 'Time', fields: ['time'], expandedColumn: true),
      PlutoColumnGroup(title: 'Note', fields: ['note'], expandedColumn: true),
    ];
    final List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        readOnly: true,
        title: 'Qty',
        field: 'qty',
        type: PlutoColumnType.text(),
        enableRowDrag: false,
        enableRowChecked: true,
      ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'Product Name',
      //   field: 'product name',
      //   type: PlutoColumnType.text(),
      //   enableRowDrag: false,
      //   enableRowChecked: true,
      // ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'Product Quantity',
      //   field: 'product quantity',
      //   type: PlutoColumnType.text(),
      //   enableRowDrag: false,
      //   enableRowChecked: true,
      // ),
      PlutoColumn(
        readOnly: true,
        title: 'Shop information',
        field: 'name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Salesman',
        field: 'addedby',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        // readOnly: true,
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.select(
            ["Pending", "In Process", "Delivered", "Cancelled", "On Hold"]),
      ),
      // PlutoColumn(
      //   readOnly: false,
      //   title: 'Bank',
      //   field: 'bank',
      //   type: PlutoColumnType.time(),
      // ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'Cheque',
      //   field: 'cheque',
      //   type: PlutoColumnType.time(),
      // ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'From Account',
      //   field: 'from',
      //   type: PlutoColumnType.time(),
      // ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'To Account',
      //   field: 'to',
      //   type: PlutoColumnType.time(),
      // ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'Payment Method',
      //   field: 'method',
      //   type: PlutoColumnType.time(),
      // ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'Received',
      //   field: 'receive',
      //   type: PlutoColumnType.time(),
      // ),
      // PlutoColumn(
      //   readOnly: true,
      //   title: 'Transaction ID',
      //   field: 'transaction',
      //   type: PlutoColumnType.time(),
      // ),
      PlutoColumn(
        readOnly: true,
        title: 'Time',
        field: 'time',
        type: PlutoColumnType.time(),
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Note',
        field: 'note',
        type: PlutoColumnType.text(),
      ),
    ];
    PlutoGridStateManager? stateManager;
    void handleOnRowChecked(PlutoGridOnRowCheckedEvent event) {
      if (event.isRow) {
        Provider.of<ordersModificationProvider>(context, listen: false)
            .mUpdateList(
                isChecked: event.isChecked!,
                orderId: event.row?.cells['id']?.value,
                value: event.row?.cells['qty']?.value);
      } else {
        if (stateManager!.checkedRows.isNotEmpty) {
          for (int i = 0; i < stateManager!.checkedRows.length; i++) {
            Provider.of<ordersModificationProvider>(context, listen: false)
                .mUpdateList(
                    isChecked: true,
                    orderId: stateManager!.checkedRows[i].cells['id']?.value,
                    value: stateManager!.checkedRows[i].cells['qty']?.value);
          }
        } else {
          Provider.of<ordersModificationProvider>(context, listen: false)
              .mResetList();
        }
      }
    }

    return Consumer2<homepage_provider, ordersModificationProvider>(
      builder: (context, provider, orderprovider, _child) {
        return Scaffold(
          body: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              width > 1100 ? sidemenu(_controller, context) : Container(),
              Expanded(
                child: body(
                  controller: _controller,
                  Dashboardscreen: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Provider.of<ordersModificationProvider>(context,
                                        listen: false)
                                    .mResetList();
                                Navigator.popAndPushNamed(context, '/homepage',
                                    arguments: _controller);
                                // Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              widget.type == 0
                                  ? "Pending Orders"
                                  : widget.type == 1
                                      ? "In-Process Orders"
                                      : widget.type == 2
                                          ? "Delivered Orders"
                                          : "Other",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .merge(const TextStyle(color: txtColor)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: PlutoGrid(
                          columns: columns,
                          rows: widget.type == 0
                              ? provider.pendingOrdersGridList
                              : widget.type == 1
                                  ? provider.inprocessOrdersGridList
                                  : widget.type == 2
                                      ? provider.completeOrdersGridList
                                      : provider.othersOrdersGridList,
                          columnGroups: columnGroups,
                          onLoaded: (PlutoGridOnLoadedEvent event) {
                            stateManager = event.stateManager;
                          },
                          onChanged: (PlutoGridOnChangedEvent event) {
                            stateManager!.setShowLoading(true);
                            log("EVENT");
                            log(event.oldValue);
                            log(event.value);
                            if (orderType.containsKey(event.value)) {
                              int orderCurrentType = orderType[event.oldValue];
                              int orderUpdatedType = orderType[event.value];
                              provider.mUpdateStatus(
                                  event.row!.cells['id']!.value,
                                  orderCurrentType,
                                  orderUpdatedType);
                              Timer(const Duration(seconds: 1), () {
                                stateManager!.removeCurrentRow();
                              });
                              stateManager!.setShowLoading(false);
                            }
                          },
                          configuration: const PlutoGridConfiguration(
                            enableColumnBorder: true,
                            gridBorderColor: Colors.transparent,
                            gridBorderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            enableGridBorderShadow: false,
                          ),
                          onRowChecked: handleOnRowChecked,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: orderprovider.selectedlist.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    orderprovider.selectedlist.length == 1
                        ? FloatingActionButton(
                            heroTag: 'btn${widget.type.toString()}',
                            onPressed: () {
                              provider
                                  .getSpecificOrderDetails(
                                      orderId: orderprovider.selectedId.last)
                                  .then((_) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        primary: false,
                                        // physics:
                                        //     NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        // itemCount: 20,
                                        itemCount: provider.orders.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          // ProductsModel? imageUrl;
                                          //
                                          // Provider.of<ProductsProvider>(context,
                                          //         listen: false)
                                          //     .getSpecificProducts(
                                          //         id: provider.orders[0].prodId)
                                          //     .then((_) {
                                          //   imageUrl =
                                          //       Provider.of<ProductsProvider>(
                                          //               context,
                                          //               listen: false)
                                          //           .specificProductData;
                                          // });
                                          //
                                          // log(imageUrl!.photoUrl.toString());
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
                                              onPressed: () {},
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
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
                                                                provider
                                                                    .orders[
                                                                        index]
                                                                    .productName,
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
                                                            Text.rich(TextSpan(
                                                                text:
                                                                    'Quantity ',
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
                                                                    text: provider
                                                                        .orders[
                                                                            index]
                                                                        .productQuantity
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
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            width > 700
                                                                ? Wrap(
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(0xFFFFA113).withOpacity(0.1),
                                                                            borderRadius: BorderRadius.circular(8)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: Text.rich(TextSpan(
                                                                              text: 'Price Per Piece ',
                                                                              style: const TextStyle(fontSize: 12, color: Color(0xFFFFA113), fontWeight: FontWeight.w500),
                                                                              children: <InlineSpan>[
                                                                                TextSpan(
                                                                                  text: provider.orders[index].productPrice.toString(),
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
                                                                            color:
                                                                                primaryColor.withOpacity(0.1),
                                                                            borderRadius: BorderRadius.circular(8)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: Text.rich(TextSpan(
                                                                              text: 'SubTotal ',
                                                                              style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500),
                                                                              children: <InlineSpan>[
                                                                                TextSpan(
                                                                                  text: provider.orders[index].subTotal.toString(),
                                                                                  style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                                )
                                                                              ])),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(0xFFFFA113).withOpacity(0.1),
                                                                            borderRadius: BorderRadius.circular(8)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: Text.rich(TextSpan(
                                                                              text: 'Price Per Piece ',
                                                                              style: const TextStyle(fontSize: 12, color: Color(0xFFFFA113), fontWeight: FontWeight.w500),
                                                                              children: <InlineSpan>[
                                                                                TextSpan(
                                                                                  text: provider.orders[index].productPrice.toString(),
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
                                                                            color:
                                                                                primaryColor.withOpacity(0.1),
                                                                            borderRadius: BorderRadius.circular(8)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: Text.rich(TextSpan(
                                                                              text: 'SubTotal ',
                                                                              style: const TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500),
                                                                              children: <InlineSpan>[
                                                                                TextSpan(
                                                                                  text: provider.orders[index].subTotal.toString(),
                                                                                  style: const TextStyle(fontSize: 12, letterSpacing: 0.5, color: primaryColor, fontWeight: FontWeight.bold),
                                                                                )
                                                                              ])),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ],
                                                        ),
                                                        provider.orders[index]
                                                                    .url !=
                                                                null
                                                            ? SizedBox(
                                                                child: Image.network(
                                                                    provider
                                                                        .orders[
                                                                            index]
                                                                        .url!),
                                                                height: 60,
                                                                width: 60,
                                                              )
                                                            : const SizedBox()
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
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                            backgroundColor: Colors.greenAccent,
                            child: const Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox(),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // orderprovider.selectedlist.length <= 1
                    //     ? FloatingActionButton(
                    //         onPressed: () {},
                    //         backgroundColor: secondryColor,
                    //         // backgroundColor: primaryColor.withOpacity(0.1),
                    //         child: const Icon(
                    //           Icons.edit,
                    //           color: Colors.white,
                    //         ),
                    //       )
                    //     : const SizedBox(),
                    const SizedBox(
                      height: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        );
      },
    );
  }
}
