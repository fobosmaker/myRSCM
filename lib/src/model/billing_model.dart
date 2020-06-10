import 'package:myrscm/src/model/tab_model.dart';
import 'card_example_model.dart';

class BillingModel{
  String statusCode;
  String message;
  BillingDataModel data;
  BillingModel({this.statusCode, this.message,this.data});

  /*BillingDataModel convertData(var data){
    List<dynamic> tab = data['tab'];
    List<TabModel> listTab = [];
    for(int i = 0; i < tab.length; i++){
      var row = tab[i];
      List<dynamic> detail = row['detail'];
      //print('item desc: ${row['org_nm']} with total row = ${detail.length}');
      List<CardExample> listDetail = [];
      for(int j = 0; j < detail.length; j++){
        var row = detail[j];
        listDetail.add(CardExample(title: row['item_nm'],date: row['item_dttm'], description: row['item_desc'], price: row['tariff']));
      }
      print('item desc: ${row['org_nm']} with total row = ${listDetail.length}');
      listTab.add(TabModel(id: row['org_id'], content: row['org_nm'], total: row['total'], data:listDetail ));
    }
    return BillingDataModel(totalSummary: data['totalSummary'],totalDeposit: data['totalDeposit'], totalTagihan: data['totalTagihan'], tab: listTab);
  }*/
}

class BillingDataModel{
  String totalSummary;
  String totalDeposit;
  String totalTagihan;
  List<TabModel> tab;
  BillingDataModel({this.totalDeposit, this.totalSummary, this.totalTagihan, this.tab});
}

class BillingDataMoreModel{
  String statusCode;
  String message;
  List<CardExample> data;
  BillingDataMoreModel({this.statusCode, this.message, this.data});
}
