import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class screenResponsiveProvider with ChangeNotifier {
  bool homePageIsHove = false;

  monHover({required bool val, required BuildContext context}) {
    homePageIsHove = val;

    // showDialog(
    //     context: context,
    //     builder: (_) => AlertDialog(
    //           title: Text('Dialog Title'),
    //           content: Text('This is my content'),
    //         ));
    if (val) {
      MyTooltip(
        message: 'message',
        child: Container(height: 40, color: Colors.blue),
      );
    } else {
      Navigator.maybePop(context);
    }

    notifyListeners();
  }
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
