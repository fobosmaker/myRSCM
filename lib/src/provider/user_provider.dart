import 'dart:convert';
import 'dart:io';
import 'package:myrscm/src/model/default_model.dart';
import 'package:myrscm/src/model/verification_model.dart';
import 'package:myrscm/src/model/patient_model.dart';

class UserProvider{

  Future<VerificationModel> login(String username, String password) async {
    String url = 'https://www.rscm.co.id/apirscm/kencana.php';
    Map map = {
      "user_nm":"UMSI",
      "key":"091ae7a29c4795860f69b4077e8b432c",
      "username":username,
      "password":password,
      "fungsi":"getLoginApps"
    };
    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));
      HttpClientResponse response = await req.close();
      print('UserProvider login response statusCode: ${response.statusCode}');

      String reply = await response.transform(utf8.decoder).join();
      print('UserProvider login response transform ${reply.toString()}');

      final jsonData = jsonDecode(reply);
      if(jsonData['data']['patient_id'] == null || jsonData['data']['patient_mrn'] == null){
        print('UserProvider login response: data tidak ditemukan');
        throw (jsonData['data']['status']);
      } else {
        print('UserProvider verification response: data ditemukan!');
        PatientModel patient = new PatientModel(patientId: jsonData['data']['patient_id'], patientMRN: jsonData['data']['patient_mrn'], patientName: jsonData['data']['patient_nm'], patientAddress: jsonData['data']['address'], patientBirthdayDate: jsonData['data']['ttl'], patientGender: jsonData['data']['gender'], patientPhone: jsonData['data']['phone']);
        return new VerificationModel( statusCode: "200", message: "Data Found", data: patient );
      }
    } catch (e){
      throw (e);
    }
  }

  Future<VerificationModel> verification(String mrn, String birthdate) async {
    String url = 'https://www.rscm.co.id/apirscm/kencana.php';
    Map map = {
      "user_nm":"UMSI",
      "key":"091ae7a29c4795860f69b4077e8b432c",
      "mrn":mrn,
      "birth_dttm":birthdate,
      "fungsi":"getVerifyApps" //getVerifyApps
    };
    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));
      HttpClientResponse response = await req.close();
      print('UserProvider verification response statusCode: ${response.statusCode}');

      String reply = await response.transform(utf8.decoder).join();
      print('UserProvider verification response transform ${reply.toString()}');

      final jsonData = jsonDecode(reply);
      if(jsonData['data']['patient_id'] == null || jsonData['data']['patient_mrn'] == null){
        print('UserProvider verification response: data tidak ditemukan');
        throw (jsonData['data']['status']);
      } else {
          print('UserProvider verification response: data ditemukan!');
          PatientModel patient = new PatientModel(patientId: jsonData['data']['patient_id'], patientMRN: jsonData['data']['patient_mrn'], patientName: jsonData['data']['patient_nm'], patientAddress: jsonData['data']['address'], patientBirthdayDate: jsonData['data']['ttl'], patientGender: jsonData['data']['gender'], patientPhone: jsonData['data']['phone']);
          return new VerificationModel( statusCode: "200", message: "Data Found", data: patient );
      }
    } catch (e){
      throw (e);
    }
  }

  Future<DefaultModel> registrasi(String patientId, String username, String password) async {
    String url = 'https://www.rscm.co.id/apirscm/kencana.php';
    Map map = {
      "user_nm":"UMSI",
      "key":"091ae7a29c4795860f69b4077e8b432c",
      "patient_id": patientId,
      "username": username,
      "password": password,
      "fungsi":"getRegisApps"

    };
    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));
      HttpClientResponse response = await req.close();
      print('UserProvider registrasi response statusCode: ${response.statusCode}');

      String reply = await response.transform(utf8.decoder).join();
      print('UserProvider registrasi response transform ${reply.toString()}');

      final jsonData = jsonDecode(reply);
      if(jsonData['data']['status'] == "200"){
        return new DefaultModel(data: new BasicModel(status: jsonData['data']['status'], message: jsonData['data']['message']));
      } else {
        throw(jsonData['data']['message']);
      }
    } catch (e){
      throw (e);
    }
  }

  Future<DefaultModel> change_password(String patientId, String password) async {
    String url = 'https://www.rscm.co.id/apirscm/kencana.php';
    Map map = {
      "user_nm":"UMSI",
      "key":"091ae7a29c4795860f69b4077e8b432c",
      "patient_id": patientId,
      "password": password,
      "fungsi":"getForgot"
    };
    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));
      HttpClientResponse response = await req.close();
      print('UserProvider change password response statusCode: ${response.statusCode}');

      String reply = await response.transform(utf8.decoder).join();
      print('UserProvider change password response transform ${reply.toString()}');

      final jsonData = jsonDecode(reply);
      if(jsonData['data']['status'] == "200"){
        return new DefaultModel(data: new BasicModel(status: jsonData['data']['status'], message: jsonData['data']['message']));
      } else {
        throw(jsonData['data']['message']);
      }
    } catch (e){
      throw (e);
    }
  }

}