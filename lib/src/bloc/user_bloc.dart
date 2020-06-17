import 'dart:async';
import 'package:myrscm/src/model/default_model.dart';
import 'package:myrscm/src/model/verification_model.dart';
import 'package:myrscm/src/provider/repository.dart';
class UserBLoc{

  final _repository = Repository();

  final _userVerificationController = StreamController<VerificationModel>.broadcast();
  Stream<VerificationModel> get dataLogin => _userVerificationController.stream;
  StreamSink<VerificationModel> get _inDataLogin => _userVerificationController.sink;
  fetchDataVerification(String mrn, String birthdate) async {
    print('fetchDataVerification: run');
    try{
      VerificationModel data = await _repository.verification(mrn, birthdate);
      print('fetchDataVerification: ${data.statusCode}, patient_id: ${data.data.patientId}, patient_name: ${data.data.patientName}, patient_mrn: ${data.data.patientMRN}, patientAddress: ${data.data.patientAddress}, patientGender: ${data.data.patientGender}, patientTTL: ${data.data.patientBirthdayDate}, patientPhone: ${data.data.patientPhone}');
      _inDataLogin.add(data);
    } catch(e) {
      print('fetchDataVerification: error found');
      _inDataLogin.addError(e);
    }
    print('fetchDataVerification: finish');
  }

  final _userRegistrationController = StreamController<DefaultModel>.broadcast();
  Stream<DefaultModel> get dataRegistration => _userRegistrationController.stream;
  StreamSink<DefaultModel> get _inDataRegistration => _userRegistrationController.sink;
  registerUser(String patientId, String username, String password) async {
    print('registerUser: run');
    try{
      print('registerUser: data from input ($patientId, $username, $password)');
      DefaultModel data = await _repository.registration(patientId,username, password);
      print('status: ${data.data.status}, message: ${data.data.message}');
      _inDataRegistration.add(data);
    } catch(e) {
      print('registerUser: error found');
      _inDataRegistration.addError(e);
    }
    print('registerUser: finish');
  }

  dispose(){
    _userVerificationController.close();
    _userRegistrationController.close();
  }

}