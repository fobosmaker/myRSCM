import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CirclePointDetailBilling extends StatefulWidget {
  String title;
  String content;
  IconData icon;
  Color color;

  CirclePointDetailBilling({this.title,this.content, this.icon, this.color});
  @override
  _CirclePointDetailBillingState createState() => _CirclePointDetailBillingState();
}

class _CirclePointDetailBillingState extends State<CirclePointDetailBilling> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              //color: Colors.blueAccent,
              color: widget.color,
              borderRadius: BorderRadius.circular(30)
          ),
          child: Icon(widget.icon, color: Colors.white,),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            )
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            widget.content,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}