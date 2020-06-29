import 'package:myrscm/src/screen/about.dart';
import 'package:myrscm/src/screen/antrian%20poli.dart';
import 'package:myrscm/src/screen/appointment_detail.dart';
import 'package:myrscm/src/screen/appointment_form_step1.dart';
import 'package:myrscm/src/screen/appointment_form_step2.dart';
import 'package:myrscm/src/screen/appointment_form_step_confirm.dart';
import 'package:myrscm/src/screen/appointment_list.dart';
import 'package:myrscm/src/screen/billing.dart';
import 'package:myrscm/src/screen/change_password.dart';
import 'package:myrscm/src/screen/content_edukasi.dart';
import 'package:myrscm/src/screen/forgot_password.dart';
import 'package:myrscm/src/screen/home.dart';
import 'package:myrscm/src/screen/jadwal_dokter.dart';
import 'package:myrscm/src/screen/more_menu.dart';
import 'package:myrscm/src/screen/login.dart';
import 'package:myrscm/src/screen/page_500.dart';
import 'package:myrscm/src/screen/page_no_connection.dart';
import 'package:myrscm/src/screen/page_no_data.dart';
import 'package:myrscm/src/screen/page_under_construction.dart';
import 'package:myrscm/src/screen/profile.dart';
import 'package:myrscm/src/screen/register.dart';
import 'package:myrscm/src/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/src/screen/verification.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/splash',
  routes: {
    //no login
    '/splash': (context) => SplashScreenPage(),
    '/login': (context) => LoginPage(),
    '/verification': (context) => VerificationPage(),
    '/jadwal_dokter': (context) => JadwalDokterPage(),
    '/forgot_password': (context) => ForgotPasswordResetPage(),
    '/registration': (context) => RegisterPage(),

    //need login
    '/home': (context) => HomePage(),
    '/more': (context) => MoreMenuPage(),
    '/content': (context) => ContentEdukasiPage(),
    '/profile': (context) => ProfilePage(),
    '/billing': (context) => BillingPage(),
    '/about': (context) => AboutPage(),
    '/change_password': (context) => ChangePasswordPage(),
    '/appointment': (context) => AppointmentListPage(),
    '/appointment/detail': (context) => AppointmentDetailPage(),
    '/appointment/form_step1': (context) => AppointmentFormStep1Page(),
    '/appointment/form_step2': (context) => AppointmentFormStep2Page(),
    '/appointment/form_confirm': (context) => AppointmentFormStepConfirmPage(),
    '/antrian_poli': (context) => AntrianPoliPage(),


    //additional
    '/under_construction': (context) => PageUnderConstruction(),
    '/server_error': (context) => Page500(),
    '/no_connection': (context) => PageNoConnection(),
    '/no_data' : (context) => PageNoData()
  },
));