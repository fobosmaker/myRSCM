import 'package:flutter/material.dart';
class ListTileDetailProfile extends StatefulWidget {
  final String title;
  final String content;
  final IconData icon;
  ListTileDetailProfile({this.title, this.content, this.icon});
  _ListTileProfileState createState() => _ListTileProfileState();
}

class _ListTileProfileState extends State<ListTileDetailProfile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(widget.icon, color: Colors.teal),
      title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.teal,
              fontSize: 13
          )
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top:5),
        child: Text(
            widget.content,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
                fontSize: 15,
                fontWeight: FontWeight.w300
            )
        ),
      ),
    );
  }
}