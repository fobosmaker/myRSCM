import 'package:myrscm/src/view/layout/layout_login.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return VerticalLayoutLogin();
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}