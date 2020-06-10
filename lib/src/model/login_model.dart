import 'package:myrscm/src/model/patient_model.dart';
class LoginModel{
  String statusCode;
  String message;
  PatientModel data;
  LoginModel({this.statusCode, this.message, this.data});
}