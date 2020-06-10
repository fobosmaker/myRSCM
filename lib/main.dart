import 'package:myrscm/src/screen/about.dart';
import 'package:myrscm/src/screen/billing.dart';
import 'package:myrscm/src/screen/change_password.dart';
import 'package:myrscm/src/screen/content_edukasi.dart';
import 'package:myrscm/src/screen/forgot_password.dart';
import 'package:myrscm/src/screen/home.dart';
import 'package:myrscm/src/screen/more_menu.dart';
import 'package:myrscm/src/screen/login.dart';
import 'package:myrscm/src/screen/profile.dart';
import 'package:myrscm/src/screen/register.dart';
import 'package:myrscm/src/screen/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/home',
  routes: {
    //no login
    '/splash': (context) => SplashScreenPage(),
    '/login': (context) => LoginPage(),
    //'/verification': (context) => VerificationPage(),
    '/forgot_password': (context) => ForgotPasswordResetPage(),
    '/registration': (context) => RegisterPage(),

    //need login
    '/home': (context) => HomePage(),
    '/more': (context) => MoreMenuPage(),
    '/content': (context) => ContentEdukasiPage(),
    '/profile': (context) => ProfilePage(),
    '/billing': (context) => BillingPage(),
    '/about': (context) => AboutPage(),
    '/change_password': (context) => ChangePasswordPage()
  },
));