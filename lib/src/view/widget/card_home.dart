import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  String imageAsset;
  double width;
  CardHome({this.imageAsset, this.width});
  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
                  image: AssetImage(widget.imageAsset),
                  fit: BoxFit.fitWidth)
        )
    );
  }
}