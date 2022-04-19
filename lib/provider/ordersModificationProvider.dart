import 'package:flutter/cupertino.dart';

class ordersModificationProvider extends ChangeNotifier {
  List<String> selectedlist = [];

  mUpdateList({required String value, required bool isChecked}) {
    if (isChecked) {
      print("YES");
      selectedlist.add(value);
    } else {
      print("NO");
      selectedlist.remove(value);
    }
    notifyListeners();
  }

  mResetList() {
    selectedlist = [];
    notifyListeners();
  }
}
