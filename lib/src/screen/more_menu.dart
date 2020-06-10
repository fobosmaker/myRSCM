import 'package:myrscm/constant.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/screen/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreMenuPage extends StatefulWidget {
  @override
  _MoreMenuPageState createState() => _MoreMenuPageState();
}

class _MoreMenuPageState extends State<MoreMenuPage> {
  MySharedPreferences sp;
  bool isGetPref = false;
  @override
  void initState() {

    //cek session first
    sp = MySharedPreferences(context: context);
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

    //if get preferences done
    return isGetPref ?
        //run page when done
        Scaffold(
          appBar: AppBar(
            title: Text('More'),
            backgroundColor: defaultAppbarColor,
            centerTitle: true,
          ),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context,'/profile');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Text(
                        'Profil pasien',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/about');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Text(
                        'Tentang RSCM Kencana',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  InkWell(
                    onTap: (){
                      print('Logout click');
                      _showMyDialog();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Text(
                        'Keluar',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                ],
              )
          )
      )
        :
        //run loading when get page
        PageLoading()
    ;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Keluar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah anda yakin ingin keluar dari aplikasi ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  'Batal',
                style: TextStyle(color: defaultAppbarColor)
              ),
              onPressed: () {
                print('cancel clicked');
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                  'Keluar',
                  style: TextStyle(color: defaultAppbarColor)
              ),
              onPressed: () {
                print('logout clicked');
                sp.clearData();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}