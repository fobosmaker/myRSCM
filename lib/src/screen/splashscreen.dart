import 'package:flutter/cupertino.dart';
import 'package:myrscm/constant.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image(
                        image: AssetImage('assets/rscmKu_love_logo.png'),
                        width: 150,
                        height: 150
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('RSCM', style: TextStyle(fontSize: 30, letterSpacing: 0, color: Colors.blue[900], fontWeight: FontWeight.w800)),
                        Text('Ku', style: TextStyle(fontSize: 30,letterSpacing: 0, color: Colors.red[900], fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                ],
              )
            )
          ),
          /*Container(
              child: Image(
                  image: AssetImage('assets/rscmKu_love_logo.png'),
                  width: 150,
                  height: 75
              )
          ),*/
          Container(
            child: Text('Powered by UMSI', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10, color: defaultAppbarColor),)
          ),
          SizedBox(height: 20,)
      ],) 
      
    );
  }
}