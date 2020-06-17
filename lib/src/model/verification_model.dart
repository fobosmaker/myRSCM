import 'package:myrscm/src/model/patient_model.dart';
class VerificationModel{
  String statusCode;
  String message;
  PatientModel data;
  VerificationModel({this.statusCode, this.message, this.data});
}