import 'package:myrscm/constant.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/view/widget/form_input.dart';
import 'package:flutter/material.dart';
class ForgotPasswordResetPage extends StatefulWidget {
  @override
  _ForgotPasswordResetPageState createState() => _ForgotPasswordResetPageState();
}

class _ForgotPasswordResetPageState extends State<ForgotPasswordResetPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  final _formResetPassword = GlobalKey<FormState>();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PatientModel args = ModalRoute.of(context).settings.arguments;
    print('forgot_pass ${args.patientId}');
    return Scaffold(
      key: globalScaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reset Password'),
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
                child: Text('Silahkan reset password anda untuk mengembalikan akses kedalam akun anda.',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
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
                      key: _formResetPassword,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FormInputWidget(label: "Password Baru", controller: newPassword, isPassword: true),
                          FormInputWidget(label: "Konfirmasi Password Baru", controller: confirmNewPassword, isPassword: true),
                          InkWell(
                            onTap: (){
                              if(_formResetPassword.currentState.validate()){
                                if(newPassword.text == confirmNewPassword.text){
                                  final snackBar = SnackBar(content: Text("Reset password successfully..."));
                                  globalScaffoldKey.currentState.showSnackBar(snackBar);
                                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                } else {
                                  final snackBar = SnackBar(content: Text("Your new password and confirm new password doesn't match!"));
                                  globalScaffoldKey.currentState.showSnackBar(snackBar);
                                }
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: defaultAppbarColor,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Text(
                                'Reset',
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
    );
  }
}