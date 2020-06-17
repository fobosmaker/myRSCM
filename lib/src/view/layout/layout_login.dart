import 'package:myrscm/constant.dart';
import 'package:myrscm/src/bloc/user_bloc.dart';
import 'package:myrscm/src/connectivity/connectivity.dart';
import 'package:myrscm/src/model/verification_model.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/widget/form_input.dart';
import 'package:myrscm/src/view/widget/widget_circular_progress.dart';
import 'package:myrscm/src/view/widget/widget_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalLayoutLogin extends StatefulWidget {
  @override
  _HorizontalLayoutStateLogin createState() => _HorizontalLayoutStateLogin();
}

class _HorizontalLayoutStateLogin extends State<HorizontalLayoutLogin> {
  final _formLogin = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();
  bool isClick = false;
  final bloc = UserBLoc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: WidgetLogo(70),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: SingleChildScrollView(
                  child: Form(
                    key: _formLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FormInputWidget(label: "Username", controller: userName, isPassword: false),

                        FormInputWidget(label: "Password", controller: password, isPassword: true),
                        ListTile(
                          onTap: (){

                            Navigator.pushNamed(context, '/verification',arguments: 0);
                          },
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: Icon(Icons.security),
                          title: Text("Lupa password?",
                              style: TextStyle(
                                  color: defaultAppbarColor,
                                  fontSize: 13,
                                  letterSpacing: 0.5
                              )
                          ),
                        ),
                        isClick == true ?
                        StreamBuilder(
                            initialData: bloc.fetchDataVerification(userName.text,password.text),
                            stream: bloc.dataLogin,
                            builder: (context, AsyncSnapshot snapshot){
                              if(snapshot.connectionState == ConnectionState.active){

                                //if error come from API
                                if(snapshot.hasError){
                                  print('layout login ${snapshot.error.toString()}');
                                  setState(() {
                                    isClick = false;
                                  });
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        //check validasi
                                        if (_formLogin.currentState.validate()) {
                                          isClick = true;
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: defaultAppbarColor,
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }

                                //default return generate widget
                                else {
                                  print('yeay');
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        //check validasi
                                        if (_formLogin.currentState.validate()) {
                                          isClick = true;
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
                                        'Login',
                                        style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );//generateWidget(snapshot.data);
                                }
                              }
                              //default run circular progress
                              return Center(child: WidgetCircularProgress());
                              })

                              //print('yeay');
                              //return Container();
                              //print('cek state: ${snapshot.connectionState}');
                             /* if(snapshot.connectionState == ConnectionState.active){
                                if(snapshot.hasData){
                                  //LoginModel result = snapshot.data;
                                 *//* if(result.statusCode == "200"){
                                    print('login sukses');
                                    //insert shared preferences (session)
                                    MySharedPreferences sp = MySharedPreferences(context: this.context);
                                    sp.saveData(pasienUjiCoba, true);
                                    WidgetsBinding.instance.addPostFrameCallback((_){
                                      setState(() {
                                        isClick = false;
                                        Navigator.pushReplacementNamed(context,'/home');
                                      });
                                    });
                                  }
                                  else{
                                    print('login status code error message ${result.message}');
                                  }*//*
                                  setState(() {
                                    isClick = false;
                                  });
                                  return Container();
                                }
                                else  return Text(snapshot.error.toString());
                              }  else {
                                return Center(
                                  child: Container(
                                      padding: EdgeInsets.all(20),
                                      child: CircularProgressIndicator()
                                  ),
                                );
                              }*/
                           /* })*/
                            :
                        InkWell(
                          onTap: (){
                            setState(() {
                              //check validasi
                              if (_formLogin.currentState.validate()) {
                                isClick = true;
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
                              'Login',
                              style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/verification',arguments: 1);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text(
                              'Registrasi',
                              style: TextStyle(color: defaultAppbarColor, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalLayoutLogin extends StatefulWidget {
  @override
  _VerticalLayoutStateLogin createState() => _VerticalLayoutStateLogin();
}

class _VerticalLayoutStateLogin extends State<VerticalLayoutLogin> {

  final _formLogin = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();
  bool isClick = false;
  final bloc = UserBLoc();
  String error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: defaultAppbarColor
        ),
        child:  SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50,),
              WidgetLogo(70),
              SizedBox(height: 50,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                  ),
                  padding: EdgeInsets.all(40),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formLogin,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FormInputWidget(label: "Username", controller: userName, isPassword: false),
                          FormInputWidget(label: "Password", controller: password, isPassword: true),
                          ListTile(
                            onTap: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationPage(flag: 0)));
                              Navigator.pushNamed(context,'/verification',arguments: 0);
                            },
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            leading: Icon(Icons.security),
                            title: Text("Lupa password?",
                                style: TextStyle(
                                    color: defaultAppbarColor,
                                    fontSize: 13,
                                    letterSpacing: 0.5
                                )
                            ),
                          ),
                          isClick == true ?
                          StreamBuilder(
                            initialData: bloc.fetchDataVerification(userName.text,password.text),
                            stream: bloc.dataLogin,
                            builder: (context, AsyncSnapshot snapshot){
                              if(snapshot.connectionState == ConnectionState.active){
                                String message= '';
                                if(snapshot.hasData) {
                                  VerificationModel data = snapshot.data;
                                  if(data.statusCode == "200"){
                                    PatientModel patient = data.data;
                                    print('loginResult: patient_id: ${patient.patientId}, patient_name: ${patient.patientName}, patient_mrn: ${patient.patientMRN}}');

                                    //save to session
                                    MySharedPreferences sp = MySharedPreferences(context: this.context);
                                    sp.savePatientPref(patient, true);

                                    //add callback
                                    WidgetsBinding.instance.addPostFrameCallback((_){
                                      setState(() {
                                        isClick = false;
                                        Navigator.pushReplacementNamed(context,'/home');
                                      });
                                    });
                                  } else {

                                    print('data error ${data.message}');
                                    //add callback
                                    WidgetsBinding.instance.addPostFrameCallback((_){
                                      setState(() {
                                        isClick = false;
                                        error = data.message;
                                      });
                                    });
                                  }
                                }

                                //if error come from API
                                if(snapshot.hasError){
                                  print('layout login ${snapshot.error.toString()}');

                                  //add callback
                                  WidgetsBinding.instance.addPostFrameCallback((_){
                                    setState(() {
                                      isClick = false;
                                      error = snapshot.error.toString();
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
                              //close keyboard input
                              FocusScope.of(context).unfocus();
                              //check input validation
                              if (_formLogin.currentState.validate()) {
                                //check user connection
                                MyConnectivity().getConnectivity().then((isConnect){
                                  if(!isConnect) Navigator.pushNamed(context, '/no_connection');
                                  else setState(() => isClick = true);
                                });
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: defaultAppbarColor,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context,'/verification',arguments: 1);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Text(
                                'Registrasi',
                                style: TextStyle(color: defaultAppbarColor, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              error,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600
                              )
                            )
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}