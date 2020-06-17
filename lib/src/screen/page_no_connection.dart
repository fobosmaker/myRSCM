import 'package:myrscm/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PageNoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: defaultAppbarColor
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage('assets/no_connection.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                      "No Internet Connection",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          wordSpacing: 1,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600
                      )
                  )
              ),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                      "Mohon cek kembali apakah anda sudah terhubung dengan koneksi internet?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          wordSpacing: 1,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w200
                      )
                  )
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: defaultAppbarContentColor,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Text(
                    'Kembali',
                    style: TextStyle(color: defaultAppbarColor, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
