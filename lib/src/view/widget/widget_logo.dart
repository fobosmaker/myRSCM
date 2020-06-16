import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*class WidgetLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 5),
                child: Image(
                  image: AssetImage('assets/rscmKu_love_logo.png'),
                  width: 70,
                  height: 70
                )
            ),
            Text('RSCM', style: TextStyle(fontSize: 35, letterSpacing: 1, color: Colors.blue[900], fontWeight: FontWeight.w800)),
            Text('Ku', style: TextStyle(fontSize: 35,letterSpacing: 1, color: Colors.red[900], fontWeight: FontWeight.w400))
          ],
        ),
      );
  }
}*/

class WidgetLogo extends StatefulWidget {
  final double size;

  WidgetLogo(this.size);

  @override
  _WidgetLogoState createState() => _WidgetLogoState(size);
}

class _WidgetLogoState extends State<WidgetLogo> {

  double size;
  _WidgetLogoState(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 5),
              child: Image(
                  image: AssetImage('assets/rscmKu_love_logo.png'),
                  width: size,
                  height: size
              )
          ),
          Text('RSCM', style: TextStyle(fontSize: size/2, letterSpacing: 0, color: Colors.blue[900], fontWeight: FontWeight.w800)),
          Text('Ku', style: TextStyle(fontSize: size/2,letterSpacing: 0, color: Colors.red[900], fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}

