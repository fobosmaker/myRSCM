import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/constant.dart';

class CirclePointDetailBilling extends StatefulWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  CirclePointDetailBilling({this.title,this.content, this.icon, this.color});
  @override
  _CirclePointDetailBillingState createState() => _CirclePointDetailBillingState();
}

class _CirclePointDetailBillingState extends State<CirclePointDetailBilling> {
  @override
  Widget build(BuildContext context) {
    return
      Expanded(
        flex: 1,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(onPressed:null, icon: Icon(widget.icon, color: defaultAppbarColor), label: Text(
            widget.title,
            style: TextStyle(/*fontSize: 14,*/ fontWeight: FontWeight.w700, color: Colors.black),
          )),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              widget.content,
              //'Rp 200,000,000',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          )
        ],
    ),
      );
  }
}