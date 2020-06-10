import 'package:myrscm/src/model/tab_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetCardBillingDetail extends StatefulWidget {
  List<TabModel> data;
  String totalSummary;

  WidgetCardBillingDetail(this.data, this.totalSummary);

  @override
  _WidgetCardBillingDetailState createState() => _WidgetCardBillingDetailState();
}

class _WidgetCardBillingDetailState extends State<WidgetCardBillingDetail> {

  NumberFormat formatter = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15,0,20,0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget>[
              DataTable(
                  sortColumnIndex: 1,
                  sortAscending: true,
                  columns: [
                    DataColumn(label:
                    Text('Lokasi', style:TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.blueAccent,
                    ) )
                    ),
                    DataColumn(label: Text('Price', style:TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.blueAccent,
                    ))),
                  ],
                  rows: generateTableContent()
              ),
            ]),
        /*Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: generateTindakan(),
          )*/

     /* Card(
          elevation:3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child:
    )*/
    );
  }

  List<DataRow> generateTableContent(){
    List<DataRow> list = [];
    int total = 0;
    for(var i = 0; i < widget.data.length; i++) {
      TabModel row = widget.data[i];
      total += 0;
      list.add(DataRow(cells: [
        DataCell(Text(row.content)),
        DataCell(Text('Rp ${formatter.format(int.parse(row.total))}')),
      ]));
    }

    list.add(DataRow(cells: [
      DataCell(Text('Total',style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.redAccent,
      ))),
      DataCell(Text('Rp ${formatter.format(int.parse(widget.totalSummary))}',style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ))),
    ]));

    return list;
  }

  List<Widget> generateTindakan(){
    List<Widget> list = new List<Widget>();
    //int total = 0;
    for(var i = 0; i < widget.data.length; i++){
      TabModel row = widget.data[i];
      //total+=0;
      list.add(
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: Text(
                        row.content,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent,
                        )
                    ),
                    subtitle: Text(
                      'Tindakan / Pemeriksaan di ${row.content}',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Center(child: Text('IDR ${row.total}'))
                )
              ],
            ),
          )
      );
    }
    //add total to list
    list.add(
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListTile(
                  title: Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      )
                  ),
                  subtitle: Text(
                    'Total tagihan anda',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(child: Text('IDR ${widget.totalSummary}'))
              )
            ],
          ),
        )
    );
    return list;
  }
}