import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myrscm/constant.dart';

class WidgetCardDetailPerjanjianOnline extends StatefulWidget {
  @override
  _WidgetCardDetailPerjanjianOnlineState createState() => _WidgetCardDetailPerjanjianOnlineState();
}

class _WidgetCardDetailPerjanjianOnlineState extends State<WidgetCardDetailPerjanjianOnline> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Card(
        //elevation: 2,
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          "No. 123456",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          //DateFormat("MMM dd, yy ").format(new DateFormat("yyyy-MM-dd hh:mm:ss").parse(DateTime.now().toIso8601String())),
                          "Jun 21, 20",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: defaultAppbarColor ),
                        ),
                      )
                    ],
                  ),
                ),
                subtitle:
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                      'URJT Poli Anak',
                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300, letterSpacing: 1)
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Lihat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11,fontWeight: FontWeight.w700, color: defaultAppbarColor ),
                ),
              ),
            ],
          ),
          onTap:(){
            Navigator.pushNamed(context,'/appointment/detail');
          },
        ),
      )
    );
  }
}
