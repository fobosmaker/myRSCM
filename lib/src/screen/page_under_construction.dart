import 'package:myrscm/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PageUnderConstruction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: defaultAppbarColor,
          //title: Text('Oops...', style: TextStyle(color: defaultAppbarContentColor)),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage('assets/under-construction.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 75),
                  child: Text(
                      "Under Progress",
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
                  padding: EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                  child: Text(
                      "Sorry for inconvenience, we're still developing this feature. Stay tune! ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          wordSpacing: 1,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w200
                      )
                  )
              ),
              /*Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: FlatButton.icon(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.refresh, color: defaultAppbarColor,), label: Text('Refresh', style: TextStyle(
                    color: defaultAppbarColor)))
            )*/
              /* InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: defaultAppbarColor,
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Text(
                  'Kembali',
                  style: TextStyle(color: defaultAppbarContentColor, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
            )*/
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
