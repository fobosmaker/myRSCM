import 'package:flutter/material.dart';
import 'package:myrscm/constant.dart';
class WidgetColumnDetailPerjanjian extends StatefulWidget {

  final String label;
  final String content;
  WidgetColumnDetailPerjanjian(this.label, this.content);

  @override
  _WidgetColumnDetailPerjanjianState createState() => _WidgetColumnDetailPerjanjianState(label, content);
}

class _WidgetColumnDetailPerjanjianState extends State<WidgetColumnDetailPerjanjian> {

  final String label;
  final String content;
  _WidgetColumnDetailPerjanjianState(this.label, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: defaultAppbarColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(content, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          ),
         SizedBox(height: 20)
         //Divider( height: 20, color: Colors.grey[300],)
        ],
      ),
    );
  }
}
