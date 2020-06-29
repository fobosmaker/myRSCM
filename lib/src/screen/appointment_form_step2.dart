import 'package:flutter/material.dart';
import 'package:myrscm/constant.dart';
import 'package:myrscm/src/bloc/appointment_bloc.dart';
import 'package:myrscm/src/model/appointment_form_model.dart';
import 'package:myrscm/src/model/list_data_model.dart';
import 'package:myrscm/src/screen/page_500.dart';
//import 'package:myrscm/src/view/widget/form_input.dart';
import 'package:myrscm/src/view/widget/form_input_datepicker.dart';
import 'package:myrscm/src/view/widget/form_input_dropdown.dart';
import 'package:myrscm/src/view/widget/widget_circular_progress.dart';

class AppointmentFormStep2Page extends StatefulWidget {
  @override
  _AppointmentFormStep2PageState createState() => _AppointmentFormStep2PageState();
}

class _AppointmentFormStep2PageState extends State<AppointmentFormStep2Page> {
  final _date = TextEditingController();
  final _schedule = TextEditingController();
  final _formAddAppointment = GlobalKey<FormState>();
  final bloc = AppointmentBloc();
  AppointmentFormModel dataForm;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dataForm =  ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder(
          initialData: bloc.fetchListDataJadwalDokter(dataForm.date, dataForm.clinicId),
          stream: bloc.dataListJadwalDokter,
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              //if error come from API
              if(snapshot.hasError){
                print(snapshot.error.toString());
                return Page500();
              }
              //default return generate widget
              else return generateWidget(snapshot.data);
            }
            //default run circular progress
            return Center(child: WidgetCircularProgress());
          }),
    );
  }

  Widget generateWidget(List<DefaultRowModel> data){
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
                child: Text('2. Pilih jadwal dokter dan cara bayar.',style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    padding: EdgeInsets.only(left: 40, top: 20, right: 40),
                    child: Form(
                      key: _formAddAppointment,
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: <Widget>[
                            FormShowModal(label: "Jadwal Dokter", controller: _schedule, data: data),
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: defaultAppbarColor,
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Text(
                                  'Verifikasi',
                                  style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: (){
                                //schedule id di split[0] , dokter id di split[1], & schedule content di split[3]
                                var split = _schedule.text.split("_");
                                AppointmentFormModel args = new AppointmentFormModel(date: dataForm.date, clinicId: dataForm.clinicId, clinicName: dataForm.clinicName, scheduleId: split[0], doctorId: split[1], scheduleName: split[2]);
                                print('${args.date},${args.clinicId},${args.clinicName},${args.scheduleId},${args.doctorId},${args.scheduleName}');
                                Navigator.pushNamed(context, '/appointment/form_confirm', arguments: args);
                              },
                            ),
                          ]
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
