import 'package:myrscm/constant.dart';
import 'package:myrscm/src/bloc/user_bloc.dart';
import 'package:myrscm/src/connectivity/connectivity.dart';
import 'package:myrscm/src/model/default_model.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/widget/form_input.dart';
import 'package:myrscm/src/view/widget/list_tile_profile.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/src/view/widget/widget_circular_progress.dart';

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
  bool isClick = false;
  final bloc = UserBLoc();

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
                  isClick == true ?
                  StreamBuilder(
                      initialData: bloc.registerUser(args.patientId, username.text, password.text),
                      stream: bloc.dataRegistration,
                      builder: (context, AsyncSnapshot snapshot){
                        if(snapshot.connectionState == ConnectionState.active){
                          String message;
                          if(snapshot.hasData) {
                            DefaultModel data = snapshot.data;
                            if(data.data.status == "200"){
                              print('register success');
                              //add callback
                              WidgetsBinding.instance.addPostFrameCallback((_){
                                setState(() {
                                  isClick = false;
                                  //set session for user
                                  MySharedPreferences sp = MySharedPreferences(context: this.context);
                                  sp.savePatientPref(args, true);
                                  //move to home
                                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                                });
                              });
                            } else {
                              print('data error ${data.data.message}');
                              message = data.data.message;
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
                      //close keyboard input
                      FocusScope.of(context).unfocus();
                      //check input validation
                      if(_formRegistration.currentState.validate()){
                        if(password.text == confirmPassword.text){
                            //check user connection
                            MyConnectivity().getConnectivity().then((isConnect){
                              if(!isConnect) Navigator.pushNamed(context, '/no_connection');
                              else setState(() => isClick = true);
                            });
                        } else {
                          print("password and confirm password doesn't match!");
                          globalScaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Your password and confirm password doesn't match!")));
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
                  )
                ],
              ),
            )
          ),
        ),
    );
  }
}