import 'package:flutter/cupertino.dart';
import 'package:myrscm/constant.dart';
import 'package:myrscm/src/screen/shared_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {

    // 3s over, navigate to a new page
    Future.delayed(Duration(seconds: 3), () {
      //cek if user is login or not
      MySharedPreferences sp = MySharedPreferences(context: this.context);
      sp.getPatientIsLogin().then((bool){
        if(bool) Navigator.pushReplacementNamed(context, '/home');
        else Navigator.pushReplacementNamed(context, '/login');
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Center(
                  child: Image(
                    image: AssetImage('assets/myRSCM.png'),
                    width: 225,
                    height: 225,
                    fit: BoxFit.scaleDown,
                  )
              )
            )
          ),
          Container(
            child: Text('Powered by UMSI', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10, color: defaultAppbarColor),)
          ),
          SizedBox(height: 20,)
      ],) 
      
    );
  }
}