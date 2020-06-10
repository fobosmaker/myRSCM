import 'package:myrscm/constant.dart';
import 'package:flutter/material.dart';
class WidgetCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.teal[100],
      strokeWidth: 2,
      valueColor: new AlwaysStoppedAnimation<Color>(defaultAppbarColor),
    );
  }
}
