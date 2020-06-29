import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myrscm/constant.dart';
import 'package:myrscm/src/model/appointment_form_model.dart';
import 'package:myrscm/src/view/widget/column_detail_perjanjian.dart';
class AppointmentFormStepConfirmPage extends StatefulWidget {
  @override
  _AppointmentFormStepConfirmPageState createState() => _AppointmentFormStepConfirmPageState();
}

class _AppointmentFormStepConfirmPageState extends State<AppointmentFormStepConfirmPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppointmentFormModel args =  ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Buat Perjanjian'),
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('Buat perjanjian anda hanya dengan beberapa langkah saja.',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('3. Verifikasi data yang sudah anda masukan',style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
                          //WidgetColumnDetailPerjanjian("Perjanjian ID", "11817096"),
                          WidgetColumnDetailPerjanjian("Tanggal Kunjungan", DateFormat("dd MMMM yyyy").format(new DateFormat("yyyy-MM-dd").parse(args.date))),
                          WidgetColumnDetailPerjanjian("Klinik/Poli",args.clinicName),
                          //WidgetColumnDetailPerjanjian("No. Rekam Medik","4461002"),
                          WidgetColumnDetailPerjanjian("Dokter DPJP & Jam",args.scheduleName),
                          InkWell(
                            onTap: (){
                              print('yeay');
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: defaultAppbarColor,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Text(
                                'Buat Perjanjian',
                                style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ]
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
