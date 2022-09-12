import 'package:flutter/cupertino.dart';

class ordersModificationProvider extends ChangeNotifier {
  List<String> selectedlist = [];
  List<String> selectedId = [];

  mUpdateList(
      {required String value,
      required bool isChecked,
      required String orderId}) {
    if (isChecked) {
      // print("YES");
      selectedlist.add(value);
      selectedId.add(orderId);
    } else {
      // print("NO");
      selectedlist.remove(value);
      selectedId.remove(orderId);
    }
    notifyListeners();
  }

  mResetList() {
    selectedlist = [];
    selectedId = [];
    notifyListeners();
  }
}
