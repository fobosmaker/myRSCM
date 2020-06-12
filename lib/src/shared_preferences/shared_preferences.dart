import 'package:myrscm/src/model/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  String patientId = 'patientId';
  String patientMRN = 'patientMRN';
  String patientName = 'patientName';
  String patientAddress = 'patientAddress';
  String patientGender = 'patientGender';
  String patientBirthdayDate = 'patientBirthdayDate';
  String patientPhone = 'patientPhone';
  String patientIsLogin = 'patientIsLogin';
  BuildContext context;

  MySharedPreferences({this.context});

  Future<void> savePatientPref(PatientModel data, bool isLogin) async {
    print('MySharedPreferences: savePatientPref run');
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('MySharedPreferences: savePatientPref data ${data.patientId} ${data.patientName} ${data.patientMRN}');
    pref.setString(patientId, data.patientId);
    pref.setString(patientMRN, data.patientMRN);
    pref.setString(patientName, data.patientName);
    pref.setString(patientBirthdayDate, data.patientBirthdayDate);
    pref.setString(patientAddress, data.patientAddress);
    pref.setString(patientGender, data.patientGender);
    pref.setString(patientPhone, data.patientPhone);
    pref.setBool(patientIsLogin, isLogin);
  }

  Future<bool> getPatientIsLogin() async {
    print('MySharedPreferences: getPatientIsLogin run');
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('MySharedPreferences: getBool : ${pref.getBool(patientIsLogin)}');
    return pref.getBool(patientIsLogin) ?? false;
  }

  Future<PatientModel> getPatientPref() async {
    print('MySharedPreferences: getPatientPref run');
    SharedPreferences pref = await SharedPreferences.getInstance();
    return PatientModel(patientId: pref.getString(patientId), patientMRN: pref.getString(patientMRN), patientName: pref.getString(patientName), patientAddress: pref.getString(patientAddress), patientBirthdayDate: pref.getString(patientBirthdayDate), patientGender: pref.getString(patientGender), patientPhone: pref.getString(patientPhone)) ?? null;
  }

  void clearData() async {
    print('MySharedPreferences: clearData run');
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
