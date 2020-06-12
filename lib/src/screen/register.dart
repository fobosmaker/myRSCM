import 'package:myrscm/constant.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/widget/form_input.dart';
import 'package:myrscm/src/view/widget/list_tile_profile.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  final _formRegistration = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PatientModel args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: globalScaffoldKey,
      backgroundColor: defaultAppbarColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled){
          return <Widget>[
            SliverAppBar(
              backgroundColor: defaultAppbarColor,
              floating: false,
              snap: false,
              pinned: true,
              centerTitle: true,
              title: Text('Registrasi'), //title on appbar
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text('Selamat datang,',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Text(args.patientName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300, color: Colors.grey[700])),
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTileDetailProfile(title: 'Tempat tanggal lahir', content: args.patientBirthdayDate, icon: Icons.cake),
                              Divider(color: Colors.grey[300]),
                              ListTileDetailProfile(title: 'Nomor Rekam Medik', content: args.patientMRN, icon: Icons.confirmation_number),
                              Divider(color: Colors.grey[300]),
                              ListTileDetailProfile(title: 'Jenis Kelamin', content: args.patientGender, icon: Icons.perm_identity),
                              Divider(color: Colors.grey[300]),
                              ListTileDetailProfile(title: 'Alamat', content: args.patientAddress, icon: Icons.home),
                              Divider(color: Colors.grey[300]),
                              ListTileDetailProfile(title: 'Telepon', content: args.patientPhone, icon: Icons.phone)
                            ],
                          )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text('Selangkah lagi untuk mendapatkan akunmu. Silahkan input username untuk login, password dengan menggunakan kombinasi huruf dan angka agar passwordmu sulit ditebak.,',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
                ),
              ]),
            ),
          ];
        },
        body: Container(
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
            ),
            padding: EdgeInsets.only(left: 40, top: 20, right: 40),
            child: Form(
              key: _formRegistration,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  FormInputWidget(label: "Username", controller: username, isPassword: false),
                  FormInputWidget(label: "Password", controller: password, isPassword: true),
                  FormInputWidget(label: "Konfirmasi Password", controller: confirmPassword, isPassword: true),
                  InkWell(
                    onTap: (){
                      if(_formRegistration.currentState.validate()){
                        if(password.text == confirmPassword.text){
                          MySharedPreferences sp = MySharedPreferences(context: this.context);
                          sp.savePatientPref(args, true);
                          Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                        } else {
                          final snackBar = SnackBar(content: Text("Your password and confirm password doesn't match!"));
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
                        'Submit',
                        style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
    );
  }
}