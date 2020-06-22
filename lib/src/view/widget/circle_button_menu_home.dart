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
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              child: Icon(widget.icon, color: Colors.white),
              backgroundColor: widget.color,
            ),
            Container(
              //width: 70,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  maxLines: 2,
                )
            ),
          ],
        ),
      ),
      onTap: widget.onclick,
    );
  }
}
