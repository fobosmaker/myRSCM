import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  final String imageAsset;
  final double width;
  final Function onclick;
  CardHome({this.imageAsset, this.width, this.onclick});
  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onclick,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                    image: AssetImage(widget.imageAsset),
                    fit: BoxFit.fitWidth)
          )
      ),
    );
  }
}