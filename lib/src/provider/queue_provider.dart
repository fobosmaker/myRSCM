import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:myrscm/src/model/queue_model.dart';

class QueueProvider{
  Future<QueueModel> getDataQueue(String patientId) async {
    //using current date;
    print('getDataQueue: run, param:$patientId, ${DateFormat("yyyy-mm-dd").format(DateTime.now()).toString()}');
    String url = 'https://www.rscm.co.id/apirscm/kencana.php';
    Map map = {
      "user_nm":"UMSI",
      "key":"091ae7a29c4795860f69b4077e8b432c",
      "patient_id":patientId,
      "date_que":DateFormat("yyyy-mm-dd").format(DateTime.now()).toString(),
      //"patient_id":"1355523",
      //"date_que":"2020-06-26",
      "fungsi":"getEncque"
    };

    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      print('getDataQueue: success');
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));

      HttpClientResponse response = await req.close();
      print('getDataQueue response: ${response.headers}');

      String reply = await response.transform(utf8.decoder).join();
      print('getDataQueue response transform: ${reply.toString()}');

      final jsonData = jsonDecode(reply);
      PatientQueue patientEnqueue = new PatientQueue(
          encounterNumber: jsonData['data']['encounter_nr'],
          orgName: jsonData['data']['org_nm'],
          queueNumber: jsonData['data']['queue_num']
      );
      if(patientEnqueue.queueNumber == null || patientEnqueue.orgName == null || patientEnqueue.queueNumber == null){
        print('getDataQueue response: data kosong');
        return null;
      } else {
        print('getDataQueue response: data ada');
        return new QueueModel(data: patientEnqueue);
      }
    } catch (e){
      print('getDataBilling: failure');
      throw(e);
    }
  }
}