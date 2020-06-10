import 'dart:async';
import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/provider/repository.dart';

class BillingBloc{
  final _repository = Repository();

  //Get billing API
  final billingController = StreamController<BillingModel>.broadcast();
  Stream<BillingModel> get dataBilling => billingController.stream;
  StreamSink<BillingModel> get _inDataBilling => billingController.sink;
  fetchDataBilling(String patientId) async {
    print('fetchDataBilling: run');
    try{
      BillingModel data = await _repository.fetchDataBilling(patientId);
      print('fetchDataBilling: result $data');
      _inDataBilling.add(data);
    } catch(e) {
      print('fetchDataBilling: result error');
      _inDataBilling.addError(e);
    }
    print('fetchDataBilling: finish');
  }

  StreamController<BillingDataMoreModel> moreData = StreamController<BillingDataMoreModel>.broadcast();
  Stream<BillingDataMoreModel> get getmoreData => moreData.stream;
  StreamSink<BillingDataMoreModel> get _getmoreData => moreData.sink;
  retrieveMoreDataBilling(String patientId, String orgId, int totalData) async {
    print('retrieveMoreDataBilling: run');
    try{
      BillingDataMoreModel data = await _repository.fetchcard(patientId, orgId, totalData);
      print('retrieveMoreDataBilling: data $data');
      _getmoreData.add(data);
    } catch(e) {
      _getmoreData.addError(e);
      print('retrieveMoreDataBilling: error');
    }
    print('retrieveMoreDataBilling: finish');
  }

  dispose(){
    billingController.close();
    moreData.close();
  }
}