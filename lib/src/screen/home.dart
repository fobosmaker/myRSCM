import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/layout/layout_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  bool isRefresh = false;
  bool isGetPref = false;
  PatientModel patient;

  @override
  void initState() {
    print('Home initState: run ');
    MySharedPreferences sp = MySharedPreferences(context: context);

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
    print('Home build: run ');
    return isGetPref == true ? VerticalLayoutDraftHome(patient) : PageLoading();
  }

  Future<Null> refresh() async {
    print('refresh run');
    setState(() {
      //isGetSP = false;
    });
    /*setState(() {
      isRefresh = true;
    });
    return (setState(() {}));*/
  }

  @override
  void dispose() {
    super.dispose();
  }
}
