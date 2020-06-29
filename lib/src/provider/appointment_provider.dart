import 'dart:convert';
import 'dart:io';
import 'package:xml/xml.dart' as xml;
import 'package:myrscm/src/model/list_data_model.dart';

class AppointmentProvider{
  String url = "http://172.16.4.3/api-rscm/index.php?/clinicInfoInternal";

  Future<List<DefaultRowModel>> getPoli() async {
    String url = "http://172.16.4.3/api-rscm/index.php?/clinicInfoInternal";
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.getUrl(Uri.parse(url));
      HttpClientResponse response = await req.close();
      print('getPoli response: ${response.headers}');
      String reply = await response.transform(utf8.decoder).join();
      print('getPoli convert xml run');
      var raw = xml.parse(reply.toString());
      var elements = raw.findAllElements('data');
      print('getPoli convert xml add to list');
      List<DefaultRowModel> data = new List<DefaultRowModel>();
      elements.forEach((row) => data.add(new DefaultRowModel(id: row.findElements('idklinik').first.text, content: row.findElements('namaklinik').first.text)));
      print('getPoli convert xml add to list success');
      return data;
    } catch (e){
      print('getPoli error $e');
      throw('Something error happen...');
    }
  }

  Future<List<DefaultRowModel>> getJadwalDokter(String date, String poliId) async {
    String url = "http://172.16.4.3/api-rscm/index.php?/drInfoInternal";
    var body =
        '<xml version="1.0" encoding="UTF-8">'
          '<data>'
            '<TglKunjungan>$date</TglKunjungan>'
            '<idpoli>$poliId</idpoli>'
          '</data>'
        '</xml>';
    // either
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.getUrl(Uri.parse(url));
      req.headers.set('content-type', 'text/xml');
      req.headers.contentLength = utf8.encode(body).length;
      req.add(utf8.encode(body));

      HttpClientResponse response = await req.close();
      print('getJadwalDokter response: ${response.headers}');
      String reply = await response.transform(utf8.decoder).join();
      print('getJadwalDokter response ${reply.toString()}');
      print('getJadwalDokter convert xml run');
      var raw = xml.parse(reply.toString());
      var elements = raw.findAllElements('data');
      print('getJadwalDokter convert xml add to list');
      List<DefaultRowModel> data = new List<DefaultRowModel>();
      print('getJadwalDokter size ${elements.length}');
      if(elements.length > 0){
        elements.forEach((row) => data.add(new DefaultRowModel(id: '${row.findElements('schedule_id').first.text}_${row.findElements('iddokter').first.text}', content: '${row.findElements('namadokter').first.text} (${row.findElements('jammulaipraktek').first.text} s/d ${row.findElements('jamtutuppraktek').first.text})')));
      } else {
        data.add(new DefaultRowModel(id: '0_0', content: 'Dokter yang bertugas'));
      }
      print('getJadwalDokter convert xml add to list success');
      return data;
    } catch (e){
      print('getJadwalDokter error $e');
    }
  }
}