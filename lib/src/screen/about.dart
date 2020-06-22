import 'package:flutter/cupertino.dart';
import 'package:myrscm/constant.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/src/view/widget/widget_logo.dart';
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  bool isGetPref = false;
  @override
  void initState() {
    MySharedPreferences sp = MySharedPreferences(context: context);
    sp.getPatientIsLogin().then((isLogin){
      print('initState: $isLogin');
      //if user not login, clear preferences and remove preferences data
      if(!isLogin) sp.clearData();

      //else get preferences done
      setState(() => isGetPref = true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isGetPref == true ?
      Scaffold(
          appBar: AppBar(
            title: Text("Tentang"),
            backgroundColor: defaultAppbarColor,
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                WidgetLogo(80),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Version ', style: TextStyle(fontSize: 18, letterSpacing: 0.5, fontWeight: FontWeight.w400)),
                      Text('1.0.0', style: TextStyle(fontSize: 18,letterSpacing: 0.5, fontWeight: FontWeight.w300))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Powered by', style: TextStyle(fontSize: 18, letterSpacing: 0.5, fontWeight: FontWeight.w200)),
                      Text(' UMSI', style: TextStyle(fontSize: 18,letterSpacing: 0, color: defaultAppbarColor, fontWeight: FontWeight.w700))
                    ],
                  ),
                ),

              ],
            ),
          ),
        )
      :
      //run loading when get page
      PageLoading()
    ;
  }
}
