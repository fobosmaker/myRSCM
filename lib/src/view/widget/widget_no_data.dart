import 'package:myrscm/constant.dart';
import 'package:flutter/material.dart';

class WidgetNoData extends StatefulWidget {

  final String title;
  final String subtitle;

  WidgetNoData({this.title, this.subtitle});

  @override
  _WidgetNoDataState createState() => _WidgetNoDataState();
}

class _WidgetNoDataState extends State<WidgetNoData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Container(
          child: Image(
            image: AssetImage('assets/no_data.png'),
            fit: BoxFit.cover,
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    wordSpacing: 1,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600
                )
            )
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 1,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w200
                )
            )
        ),
        InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: defaultAppbarContentColor,
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Text(
                  'Kembali',
                  style: TextStyle(color: defaultAppbarColor, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}