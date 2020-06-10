import 'package:flutter/material.dart';
class CircleButtonMenuHome extends StatefulWidget {

  final String title;
  final IconData icon;
  final Color color;
  final Function onclick;

  CircleButtonMenuHome({this.title, this.icon, this.color, this.onclick});

  @override
  _CircleButtonMenuHomeState createState() => _CircleButtonMenuHomeState();
}

class _CircleButtonMenuHomeState extends State<CircleButtonMenuHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: CircleAvatar(
            radius: 30,
            child: Icon(widget.icon, color: Colors.white),
            backgroundColor: widget.color,
          ),
          onTap: widget.onclick,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            )
        ),
      ],
    );
  }
}
