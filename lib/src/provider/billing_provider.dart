import 'dart:convert';
import 'dart:io';
import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/model/card_example_model.dart';
import 'package:myrscm/src/model/tab_model.dart';

class BillingProvider{

  Future<BillingModel> getDataBilling(String patientId) async {
    print('getDataBilling: run');
    String url = 'https://www.rscm.co.id/apirscm/kencana.php';
    Map map = {
      "user_nm":"UMSI",
      "key":"091ae7a29c4795860f69b4077e8b432c",
      "patient_id":patientId,
      "fungsi":"getBilling"
    };
    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      print('getDataBilling: success');
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));

      HttpClientResponse response = await req.close();
      print('getDataBilling response: ${response.headers}');


      String reply = await response.transform(utf8.decoder).join();
      print('getDataBilling response transform: ${reply.toString()}');

      final jsonData = jsonDecode(reply);
      if(jsonData['statusCode'] == '200'){
        print('getDataBiling response statusCode: 200');
        if(jsonData['data'].runtimeType == [].runtimeType  || jsonData['data'] == 'gagal' || jsonData['data'] == null){
          print('getDataBiling response: data kosong');
          return null;
        } else {
          print('getDataBiling response: data ada');
          return new BillingModel( statusCode: jsonData['statusCode'], message: jsonData['message'],  data: convertGetBillingData(jsonData['data']) );
        }
      } else throw('Response error from server');
    } catch (e){
      print('getDataBilling: failure');
      throw(e);
    }
  }

  BillingDataModel convertGetBillingData(var data){

    print('convertGetBillingData: run');

    var totalSummary = data['totalSummary'] == null ? "0": data['totalSummary'];
    var totalDeposit = data['totalDeposit'] == null ? "0": data['totalDeposit'];
    var totalTagihan = data['totalTagihan'] == null ? "0": data['totalTagihan'];
    List<TabModel> groupTab = [];

    if(data['tab'] != null){
      print('convertGetBillingData: generate billing detail');
      try{
        //bentuk response map
        print('convertGetBillingData: bentuk response map');
        Map<String, dynamic> map = data['tab'];
        map.forEach((key,val) => groupTab.add(new TabModel(id: map[key]['org_id'], content: map[key]['org_nm'], total: map[key]['total'], data:getBillingDetail(map[key]['detail']) )));
        print('convertGetBillingData success');
      } catch(e){
        //bentuk response list
        print('convertGetBillingData: bentuk response list');
        List<dynamic> tab = data['tab'];
        for(int i = 0; i < tab.length; i++){
          groupTab.add(
              new TabModel(
                  id: tab[i]['org_id'],
                  content: tab[i]['org_nm'],
                  total: tab[i]['total'],
                  data: getBillingDetail(tab[i]['detail'])
              )
          );
        }
      }
    }
    print('convertGetBillingData: result summary: $totalSummary, deposit: $totalDeposit, tagihan: $totalTagihan, data:${groupTab.length}');
    return new BillingDataModel(totalSummary: totalSummary, totalDeposit: totalDeposit, totalTagihan: totalTagihan, tab:groupTab);
  }
  
  List<CardExample> getBillingDetail(List<dynamic> data){
    print('getBillingdetail: run');
    List<CardExample> listDetail = [];

    try{
      print('getBillingdetail: generate card billing detail');
      for(int j = 0; j < data.length; j++) listDetail.add(new CardExample(id: data[j]['item_id'], title: data[j]['item_nm'],date: data[j]['item_dttm'], description: data[j]['item_desc'], price: data[j]['tariff']));
      print('getBillingdetail generate card success');
    } catch(e) {
      print('getBillingdetail generate card error: $e');
    }

    print('getBillingdetail: finish');
    return listDetail;
  }

  Future<BillingDataMoreModel> getMoreBillingDetail(String patientId, String orgId, int totalData) async{
    print('getMoreBillingDetail run');
    String url = 'https://www.rscm.co.id/apirscm/kencana.php';
    Map map = {
      "user_nm":"UMSI",
      "key":"091ae7a29c4795860f69b4077e8b432c",
      "patient_id":patientId,
      "org_id":orgId,
      "record":totalData,
      "fungsi":"getLoadMore"
    };
    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));

      HttpClientResponse response = await req.close();
      String reply = await response.transform(utf8.decoder).join();
      final jsonData = jsonDecode(reply);
      print('getMoreBillingDetail response: $jsonData');

      if(jsonData['statusCode'] == '200'){
        try{
          List<dynamic> data = jsonData['data'];
          print('getMoreBillingDetail data length : ${data.length}');
          if(jsonData['data'].runtimeType == [].runtimeType && data.length == 0){
            print('getMoreBillingDetail: data kosong');
            return null;
          } else {
            print('getMoreBillingDetail: data ada');
            return new BillingDataMoreModel(statusCode: jsonData['statusCode'], message: jsonData['message'],  data: getBillingDetail(data) );
          }
        } catch(e){
          print('getMoreBillingDetail failed to generate card detail');
          return null;
        }
      } else throw('Response error from server');
    } catch (e){
      print('getMoreBillingDetail: error');
      throw(e);
    }
  }

}