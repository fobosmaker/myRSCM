import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/src/bloc/queue_bloc.dart';
import 'package:myrscm/src/connectivity/connectivity.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/model/queue_model.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/widget/list_tile_profile.dart';
import 'package:myrscm/src/view/widget/widget_no_data.dart';

import '../../constant.dart';

class AntrianPoliPage extends StatefulWidget {
  @override
  _AntrianPoliPageState createState() => _AntrianPoliPageState();
}

class _AntrianPoliPageState extends State<AntrianPoliPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  final bloc = QueueBloc();
  PatientModel patient;
  bool isGetPref = false;
  bool isGetData = false;

  @override
  void initState() {
    // check user connectivity
    MyConnectivity().getConnectivity().then((isConnect){
      // if user has no connectivity
      if(!isConnect) Navigator.pushNamed(context, '/no_connection');
      else {
        // check session
        MySharedPreferences sp = MySharedPreferences(context: context);
        sp.getPatientIsLogin().then((isLogin){
          print('initState: $isLogin');
          //if user not login, clear preferences and remove preferences data
          if(!isLogin) sp.clearData();
          else {
            //if user is login but no data, clear preferences and remove
            sp.getPatientPref().then((patient){
              if(patient == null) sp.clearData();
              else {
                //reload page
                setState((){
                  this.patient = patient;
                  isGetPref = true;
                });
              }
            });
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getData(){
    return FutureBuilder<QueueModel>(
        future: bloc.getQueue(patient.patientId),
        builder:(context, snapshot){
          // if snapshot done
          if(snapshot.connectionState == ConnectionState.done){

            //if return api has error
            if(snapshot.hasError){
              print('getData : has error');
              //add callback
              WidgetsBinding.instance.addPostFrameCallback((_){
                Navigator.pushReplacementNamed(context,'/server_error');
              });
              return Container(child: Text(''));
            } else {
              //if snapshot has data
              if(snapshot.hasData){
                print('getData : success & has data');
                return generateView(snapshot.data.data);
              }
              //if snapshot has no data
              else {
                print('getData : has null');
                return WidgetNoData(title: 'Tidak ada antrian', subtitle: 'Tidak ada data antrian pada hari ini di berbagai Poli');
              }
            }
          } else {
            print('getData connectionState: ${snapshot.connectionState}');
            return PageLoading();
          }
        }
    );
  }

  Widget generateView(PatientQueue data){
    return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //color: Colors.white,
              ),
              child: Column( mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTileDetailProfile(title: 'Nomor Antrian', content: data.queueNumber, icon: Icons.confirmation_number),
                    Divider(color: Colors.grey[300]),
                    ListTileDetailProfile(title: 'Poli', content: data.orgName, icon: Icons.local_hospital),
                    Divider(color: Colors.grey[300]),
                    ListTileDetailProfile(title: 'Encounter', content: data.encounterNumber, icon: Icons.format_list_numbered),
                    Divider(color: Colors.grey[300]),
                  ])
          ),
          SizedBox(height: 40,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(padding: EdgeInsets.all(10),
                  child: Text('Catatan:',
                      style: TextStyle(
                        //color: Colors.black,
                          letterSpacing: 0.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                      )
                  )
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text('*) Saya menyetujui BPJS Kesehatan menggunakan informasi Medis Pasien jika diperlukan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //color: Colors.black,
                        letterSpacing: 0.5,
                        fontSize: 11,
                        fontWeight: FontWeight.w300
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text('*) Surat Elegibilitas Peserta (SEP) BUKAN sebagai bukti penjaminan peserta.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //color: Colors.black,
                        letterSpacing: 0.5,
                        fontSize: 11,
                        fontWeight: FontWeight.w300
                    )
                ),
              )
            ],
          ),
          SizedBox(height: 40,),
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return isGetPref == true?
      Scaffold(
        key: globalScaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Antrian Poli'),
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
                  child: Text('Dapatkan informasi terkait nomor antrian pendaftaran online melalui genggaman anda.',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                      ),
                      padding: EdgeInsets.only(left: 40, top: 40, right: 40),
                      child: getData()
                      /*isGetData == false ?
                      getData()
                          :
                      ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  //color: Colors.white,
                                ),
                                child: Column( mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      ListTileDetailProfile(title: 'Nomor Antrian', content: "200", icon: Icons.confirmation_number),
                                      Divider(color: Colors.grey[300]),
                                      ListTileDetailProfile(title: 'Poli', content: "Anak Hematologi Onkologi / Kiara - Poli Hematologi", icon: Icons.local_hospital),
                                      Divider(color: Colors.grey[300]),
                                      ListTileDetailProfile(title: 'Encounter', content: "3036", icon: Icons.format_list_numbered),
                                      Divider(color: Colors.grey[300]),
                                    ])
                            ),
                            SizedBox(height: 40,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(padding: EdgeInsets.all(10),
                                    child: Text('Catatan:',
                                        style: TextStyle(
                                            //color: Colors.black,
                                            letterSpacing: 0.5,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500
                                        )
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text('*) Saya menyetujui BPJS Kesehatan menggunakan informasi Medis Pasien jika diperlukan',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      //color: Colors.black,
                                        letterSpacing: 0.5,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300
                                    )
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text('*) Surat Elegibilitas Peserta (SEP) BUKAN sebagai bukti penjaminan peserta.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      //color: Colors.black,
                                        letterSpacing: 0.5,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300
                                    )
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 40,),
                          ]
                      )*/
                  ),
                ),
              ],
            ),
          ),
        ),
      ) : PageLoading();
  }
}
