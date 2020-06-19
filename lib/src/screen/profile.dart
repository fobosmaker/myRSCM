import 'package:myrscm/constant.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/widget/card_profile.dart';
import 'package:myrscm/src/view/widget/list_tile_profile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  MySharedPreferences sp;
  bool isGetPref = false;
  PatientModel patient;

  @override
  void initState() {

  //check user session
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
  Widget build(BuildContext context) {

    //if get preferences done
    return isGetPref == true ?
      Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
        backgroundColor: defaultAppbarColor,
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:10),
              child: CardProfile(patient.patientMRN,patient.patientName),
            ),
            //edit profile
            /*ListTile(
                contentPadding: EdgeInsets.fromLTRB(15,20,15,0),
                title: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: Text('Akun', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700))
                ),
                subtitle: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text('Setting password untuk akun anda', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
                ),
                trailing : FlatButton.icon(
                    onPressed: (){
                      Navigator.pushNamed(context,'/change_password');
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Ubah')
                )
            ),
            */
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15,20,15,0),
              title: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: Text('Biodata', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
              ),
              subtitle: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text('Profil pasien dalam sistem electornic health record', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTileDetailProfile(title: 'Tempat tanggal lahir', content: patient.patientBirthdayDate, icon: Icons.cake),
                    Divider(color: Colors.grey[300]),
                    ListTileDetailProfile(title: 'Nomor Rekam Medik', content: patient.patientMRN, icon: Icons.confirmation_number),
                    Divider(color: Colors.grey[300]),
                    ListTileDetailProfile(title: 'Jenis Kelamin', content: patient.patientGender, icon: Icons.person),
                    Divider(color: Colors.grey[300]),
                    ListTileDetailProfile(title: 'Alamat', content: patient.patientAddress, icon: Icons.home),
                    Divider(color: Colors.grey[300]),
                    ListTileDetailProfile(title: 'Telepon', content: patient.patientPhone, icon: Icons.phone)
                  ],
                )
            )
          ],
        ),
      )
    )
        :
    //else loading when get page
      PageLoading()
    ;
  }
}