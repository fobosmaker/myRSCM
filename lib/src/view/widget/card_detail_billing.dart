import 'package:myrscm/src/model/card_example_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class WidgetCardDetailBilling extends StatefulWidget {

  final CardExample cardExample;

  WidgetCardDetailBilling(this.cardExample);

  @override
  _WidgetCardDetailBillingState createState() => _WidgetCardDetailBillingState();
}

class _WidgetCardDetailBillingState extends State<WidgetCardDetailBilling> {

  NumberFormat formatter = new NumberFormat("#,###");
  DateTime tempDate;

  @override
  void initState() {
    tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.cardExample.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(4),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            widget.cardExample.title,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child:Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            DateFormat("MMM dd, yy ").format(tempDate),
                            //widget.cardExample.date,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300 ),
                          ),
                        ),
                      )
                    ],
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                child: Text(
                  widget.cardExample.description,
                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300, letterSpacing: 1),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Rp ${formatter.format(int.parse(widget.cardExample.price))}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700 ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}