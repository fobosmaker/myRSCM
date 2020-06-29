import 'package:myrscm/constant.dart';
import 'package:myrscm/src/bloc/user_bloc.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/widget/form_input.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/src/view/widget/widget_circular_progress.dart';
class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  final _formChangePassword = GlobalKey<FormState>();
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();
  bool isGetPref = false;
  MySharedPreferences sp;
  PatientModel patient;
  bool isClick = false;
  final bloc = UserBLoc();

  @override
  void initState() {
    sp = MySharedPreferences(context: context);
    sp.getPatientIsLogin().then((isLogin){
      print('initState: $isLogin');
      //if user not login, clear preferences and remove preferences data
      if(!isLogin) sp.clearData();
      else {

        //if user is login but no data, clear preferences and remove
        sp.getPatientPref().then((patient){
          if(patient == null) sp.clearData();
          else {
            this.patient = patient;
            setState(() => isGetPref = true);
          }
        });

      }
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isGetPref == true ?
      Scaffold(
        key: globalScaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ubah Password'),
        backgroundColor: defaultAppbarColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: defaultAppbarColor
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text('Gunakan kombinasi huruf dan angka agar passwordmu sulit ditebak.',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                  ),
                  padding: EdgeInsets.only(left: 40, top: 40, right: 40),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formChangePassword,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FormInputWidget(label: "Password Lama", controller: oldPass, isPassword: true),
                          FormInputWidget(label: "Password Baru", controller: newPass, isPassword: true),
                          FormInputWidget(label: "Konfirmasi Password Baru", controller: confirmPass, isPassword: true),
                          isClick == true ?
                          StreamBuilder(
                              initialData: bloc.changePassword(patient.patientId, newPass.text),
                              stream: bloc.dataChangePassword,
                              builder: (context, AsyncSnapshot snapshot){
                                if(snapshot.connectionState == ConnectionState.active){

                                  //if error come from API
                                  if(snapshot.hasError){
                                    print('change password has error');
                                    WidgetsBinding.instance.addPostFrameCallback((_){
                                      //add callback
                                      setState(() {
                                        isClick = false;
                                        final snackBar = SnackBar(content: Text(snapshot.error.toString()));
                                        Scaffold.of(context).showSnackBar(snackBar);
                                      });
                                    });
                                  }

                                  //if success
                                  if(snapshot.hasData) {
                                    print('change password success');
                                    //add callback
                                    WidgetsBinding.instance.addPostFrameCallback((_){
                                      setState(() {
                                        isClick = false;
                                        //clear session
                                        sp.clearData();
                                        //move to login
                                        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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
                                if(_formChangePassword.currentState.validate()){
                                  print('valid input ${oldPass.text} ${newPass.text} ${confirmPass.text} ');
                                  if(newPass.text == confirmPass.text){
                                    setState(() => isClick = true);
                                  } else {
                                    final snackBar = SnackBar(content: Text("Your new password and confirm new password doesn't match!"));
                                    globalScaffoldKey.currentState.showSnackBar(snackBar);
                                  }

                                  //Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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
                                'Ubah',
                                style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
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
    )
      :
      PageLoading()
    ;
  }
}