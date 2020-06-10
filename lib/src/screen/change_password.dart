import 'package:myrscm/constant.dart';
import 'package:myrscm/src/screen/shared_preferences.dart';
import 'package:myrscm/src/view/widget/form_input.dart';
import 'package:flutter/material.dart';
class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final _formChangePassword = GlobalKey<FormState>();
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //check user session
    MySharedPreferences sp = MySharedPreferences(context: this.context);
    sp.checkBoolean();

    return Scaffold(
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
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(_formChangePassword.currentState.validate()){
                                  print('valid input ${oldPass.text} ${newPass.text} ${confirmPass.text} ');
                                  sp.clearData();
                                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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
    );
  }
}