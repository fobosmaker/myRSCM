import 'package:myrscm/constant.dart';
import 'package:myrscm/src/model/tab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetCardBillingDetail extends StatefulWidget {
  final List<TabModel> data;
  final String totalSummary;

  WidgetCardBillingDetail(this.data, this.totalSummary);

  @override
  _WidgetCardBillingDetailState createState() => _WidgetCardBillingDetailState(data,totalSummary);
}

class _WidgetCardBillingDetailState extends State<WidgetCardBillingDetail> {

  NumberFormat formatter = new NumberFormat("#,###");
  final List<TabModel> data;
  final String totalSummary;
  
  _WidgetCardBillingDetailState(this.data, this.totalSummary);
  
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20,0,20,20),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget>[
              DataTable(
                  /*sortColumnIndex: 1,
                  sortAscending: true,*/
                  columns: [
                    DataColumn(label:
                    Text('Lokasi', style:TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: defaultAppbarColor,
                    ) )
                    ),
                    DataColumn(label: Text('Price', style:TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: defaultAppbarColor,
                    )))
                  ],
                  rows: generateTableContent()
              )
            ])
    );
  }

  List<DataRow> generateTableContent(){
    List<DataRow> list = [];
    for(var i = 0; i < data.length; i++) {
      TabModel row = data[i];
      list.add(DataRow(cells: [
        DataCell(Text(
            row.content,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300
          ),
        )),
        DataCell(Text('Rp ${formatter.format(int.parse(row.total))}',
          style: TextStyle(
            fontSize: 12,
          fontWeight: FontWeight.w300
          ),
        )),
      ]));
    }

    list.add(DataRow(cells: [
      DataCell(Text('Total',style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: defaultAppbarColor,
      ))),
      DataCell(Text('Rp ${formatter.format(int.parse(totalSummary))}',style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ))),
    ]));
    return list;
  }
}