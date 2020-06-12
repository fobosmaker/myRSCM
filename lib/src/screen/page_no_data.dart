import 'package:myrscm/constant.dart';
import 'package:myrscm/src/view/widget/widget_no_data.dart';
import 'package:flutter/material.dart';
class PageNoData extends StatefulWidget {
  final String title;
  final String subtitle;
  PageNoData({this.title, this.subtitle});
  @override
  _PageNoDataState createState() => _PageNoDataState();
}

class _PageNoDataState extends State<PageNoData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: defaultAppbarColor,
      ),
      body: WidgetNoData(title: widget.title,subtitle: widget.subtitle,),
    );
  }
}
