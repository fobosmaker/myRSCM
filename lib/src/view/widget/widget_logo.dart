import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class WidgetLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        child: Center(
            child: Image(
                image: AssetImage('assets/rscm_kencana_logo.jpg')
            )
        )
    );
  }
}
/*

Widget widgetLogo(){
    return Container(
      padding: EdgeInsets.all(4),
      child: Center(
          child: Image(
              image: AssetImage('assets/rscm_kencana_logo.jpg')
          )
      )
  );
}*/
