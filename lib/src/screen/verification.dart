import 'package:myrscm/constant.dart';
import 'package:myrscm/src/bloc/user_bloc.dart';
import 'package:myrscm/src/model/login_model.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/view/widget/form_input.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/src/view/widget/form_input_datepicker.dart';
import 'package:myrscm/src/view/widget/widget_circular_progress.dart';

/*
  * flag digunakan untuk menentukan page mana selanjutnya ketika button verifikasi di klik. flag berupa integer
  * flag = 0 ( forgot password reset )
  * flag = 1 ( registrasi user)
*/

class VerificationPage extends StatefulWidget {

  final int flag;
  VerificationPage({this.flag});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  final _formVerification = GlobalKey<FormState>();
  final nomorRekamMedik = TextEditingController();
  final tanggalLahir = TextEditingController();
  bool isClick = false;
  final bloc = UserBLoc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Verifikasi'),
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
              child: widget.flag == 0 ?
              Text('Sebelum anda mereset password, kami akan melakukan verifikasi data nomor rekam medik anda kedalam sistem kami untuk memastikan anda merupakan pasien dari RSCM Kencana',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,)
                  :
              Text('Sebelum anda melakukan registrasi, kami akan melakukan verifikasi data nomor rekam medik anda kedalam sistem kami untuk memastikan anda merupakan pasien dari RSCM Kencana',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
                padding: EdgeInsets.only(left: 40, top: 40, right: 40),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formVerification,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FormInputWidget(label: "Nomor Rekam Medik", controller: nomorRekamMedik, isPassword: false),
                        FormDatePickerWidget(label: "Tanggal Lahir", controller: tanggalLahir),
                        isClick == true ?
                        StreamBuilder(
                            initialData: bloc.fetchDataLogin(nomorRekamMedik.text,tanggalLahir.text),
                            stream: bloc.dataLogin,
                            builder: (context, AsyncSnapshot snapshot){
                              if(snapshot.connectionState == ConnectionState.active){
                                String message;
                                if(snapshot.hasData) {
                                  LoginModel data = snapshot.data;
                                  if(data.statusCode == "200"){
                                    PatientModel patient = data.data;
                                    print('loginResult: patient_id: ${patient.patientId}, patient_name: ${patient.patientName}, patient_mrn: ${patient.patientMRN}}');

                                    //add callback
                                    WidgetsBinding.instance.addPostFrameCallback((_){
                                      setState(() {
                                        isClick = false;
                                        if(widget.flag == 0) Navigator.pushNamed(context,'/forgot_password',arguments: patient);
                                        if(widget.flag == 1) Navigator.pushNamed(context,'/registration',arguments: patient);
                                      });
                                    });
                                  } else {
                                    print('data error ${data.message}');
                                    message = data.message;
                                  }
                                }

                                //if error come from API
                                if(snapshot.hasError){
                                  print('layout login ${snapshot.error.toString()}');
                                  message = snapshot.error.toString();
                                  //default return generate widget
                                  WidgetsBinding.instance.addPostFrameCallback((_){
                                    setState(() {
                                      isClick = false;
                                      final snackBar = SnackBar(content: Text(message));
                                      Scaffold.of(context).showSnackBar(snackBar);
                                    });
                                  });
                                }
                              }
                              //default run circular progress
                              return Center(child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: WidgetCircularProgress(),
                              ));
                            })
                            :
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(_formVerification.currentState.validate()){
                                setState(() {
                                  isClick = true;
                                });
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text(
                              'Kembali',
                              style: TextStyle(color: defaultAppbarColor, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
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