import 'dart:async';

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

class pendingOrders extends StatelessWidget {
  pendingOrders({Key? key, required this.type}) : super(key: key);
  final int type;

  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final List<PlutoColumnGroup> columnGroups = [
      PlutoColumnGroup(title: 'Qty', fields: ['qty'], expandedColumn: true),
      PlutoColumnGroup(
          title: 'Shop information', fields: ['name'], expandedColumn: true),
      PlutoColumnGroup(
          title: 'Status', fields: ['status'], expandedColumn: true),
      PlutoColumnGroup(
          title: 'Salesman', fields: ['addedby'], expandedColumn: true),
      PlutoColumnGroup(title: 'Payment', fields: [
        'bank',
        'cheque',
        'from',
        'to',
        'method',
        'receive',
        'transaction'
      ]),
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
      PlutoColumn(
        readOnly: false,
        title: 'Bank',
        field: 'bank',
        type: PlutoColumnType.time(),
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Cheque',
        field: 'cheque',
        type: PlutoColumnType.time(),
      ),
      PlutoColumn(
        readOnly: true,
        title: 'From Account',
        field: 'from',
        type: PlutoColumnType.time(),
      ),
      PlutoColumn(
        readOnly: true,
        title: 'To Account',
        field: 'to',
        type: PlutoColumnType.time(),
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Payment Method',
        field: 'method',
        type: PlutoColumnType.time(),
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Received',
        field: 'receive',
        type: PlutoColumnType.time(),
      ),
      PlutoColumn(
        readOnly: true,
        title: 'Transaction ID',
        field: 'transaction',
        type: PlutoColumnType.time(),
      ),
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
                value: event.row?.cells['qty']?.value);
      } else {
        if (stateManager!.checkedRows.length > 0) {
          for (int i = 0; i < stateManager!.checkedRows.length; i++) {
            Provider.of<ordersModificationProvider>(context, listen: false)
                .mUpdateList(
                    isChecked: true,
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
              sidemenu(_controller),
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
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              type == 0
                                  ? "Pending Orders"
                                  : type == 1
                                      ? "In-Process Orders"
                                      : type == 2
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
                          rows: type == 0
                              ? provider.pendingOrdersGridList
                              : type == 1
                                  ? provider.inprocessOrdersGridList
                                  : type == 2
                                      ? provider.completeOrdersGridList
                                      : provider.othersOrdersGridList,
                          columnGroups: columnGroups,
                          onLoaded: (PlutoGridOnLoadedEvent event) {
                            stateManager = event.stateManager;
                          },
                          onChanged: (PlutoGridOnChangedEvent event) {
                            stateManager!.setShowLoading(true);
                            print("EVENT");
                            print(event.oldValue);
                            print(event.value);
                            if (orderType.containsKey(event.value)) {
                              int orderCurrentType = orderType[event.oldValue];
                              int orderUpdatedType = orderType[event.value];
                              provider.mUpdateStatus(
                                  event.row!.cells['id']!.value,
                                  orderCurrentType,
                                  orderUpdatedType);
                              Timer(Duration(seconds: 1), () {
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
          floatingActionButton: orderprovider.selectedlist.length > 0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    orderprovider.selectedlist.length <= 1
                        ? FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: secondryColor,
                            // backgroundColor: primaryColor.withOpacity(0.1),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        );
      },
    );
  }
}
