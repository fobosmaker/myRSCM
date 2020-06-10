import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetCardBillingStatus extends StatefulWidget {
  final String paid;
  final String unpaid;

  WidgetCardBillingStatus(this.paid,this.unpaid);

  @override
  _WidgetCardBillingStatusState createState() => _WidgetCardBillingStatusState();
}

class _WidgetCardBillingStatusState extends State<WidgetCardBillingStatus> {
  NumberFormat formatter = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0,4,0,4),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded( //PAID
            flex: 1,
            child:  Card(
              elevation:1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListTile(
                leading: Icon(Icons.library_books, color:Colors.green,size: 45,),
                title: Text('Deposit',style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),),
                subtitle: Text('Rp ${formatter.format(int.parse(widget.paid))}', style: TextStyle(color: Colors.black, fontSize:12, fontWeight: FontWeight.w400)),
              ),
              /*ListTile(
                leading: Icon(Icons.library_books, color:Colors.green,size: 45,),
                title: Text('Deposit',style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),),
                subtitle: Text('Rp ${formatter.format(int.parse(widget.paid))}', style: TextStyle(color: Colors.black, fontSize:12, fontWeight: FontWeight.w400)),
              ),*/
            ),
          ),
          Expanded( //UNPAID
            flex: 1,
            child: Card(
              elevation:1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListTile(
                leading: Icon(Icons.library_books, color:Colors.red, size:45),
                title: Text('Tagihan', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),),
                subtitle: Text('Rp ${formatter.format(int.parse(widget.unpaid))}', style: TextStyle(color: Colors.black, fontSize:12, fontWeight: FontWeight.w400)),
              ),
            ),
          )
        ],
      ) ,
    );
  }
}