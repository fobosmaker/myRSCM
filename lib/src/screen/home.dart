import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/screen/shared_preferences.dart';
import 'package:myrscm/src/view/layout/draft_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  bool isRefresh = false;
  bool isGetPref = false;
  String patientId;
  String patientName;
  String patientMRN;

  @override
  void initState() {
    print('Home initState: run ');
    MySharedPreferences sp = MySharedPreferences(context: context);
    sp.getPatientIsLogin().then((isLogin){
      print('initState: $isLogin');
      if(isLogin){
        sp.getPatientMRN().then((patientMRN){
          print('initstate: $patientMRN');
          this.patientMRN = patientMRN;
          if(patientMRN != null){
            sp.getPatientName().then((patientName){
              this.patientName = patientName;
              print('initstate: $patientName');
              //reload state
              setState(() => isGetPref = true);
            });
          } else sp.clearData();
        });
      } else sp.clearData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Home build: run ');
    return isGetPref == true ? VerticalLayoutDraftHome(patientMRN,patientName) : PageLoading();
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
