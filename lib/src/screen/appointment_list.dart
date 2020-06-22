import 'package:flutter/material.dart';
import 'package:myrscm/constant.dart';
import 'package:myrscm/src/view/widget/card_detail_perjanjian_online.dart';
import 'package:myrscm/src/view/widget/widget_no_data.dart';
class AppointmentListPage extends StatefulWidget {
  @override
  _AppointmentListPageState createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Perjanjian Online'),
        backgroundColor: defaultAppbarColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: defaultAppbarColor
        ),
        child:  SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text('Atur sendiri perjanjian dengan Dokter DPJP untuk Poli/Klinik tujuan kapan saja.',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child:
                    //if no data
                    //WidgetNoData(title: "Ayo buat perjanjian secara online", subtitle: "Perjanjian tidak ditemukan. Apakah anda sudah pernah membuat perjanjian? Jika belum, tekan tombol berlogo '+' untuk membuat perjanjian.", isBack: true,),
                    //else
                    ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        WidgetCardDetailPerjanjianOnline(),
                        SizedBox(
                          height: 72,
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context,'/appointment/add'),
        backgroundColor: defaultAppbarColor,
        foregroundColor: defaultAppbarContentColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
