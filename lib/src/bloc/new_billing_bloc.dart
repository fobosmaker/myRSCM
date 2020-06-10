import 'dart:async';

import 'package:myrscm/src/bloc/bloc.dart';
import 'package:myrscm/src/event/billing_event.dart';
import 'package:myrscm/src/model/card_example_model.dart';
import 'package:myrscm/src/provider/repository.dart';

class NewBillingBloc {
  final _repository = Repository();
  StreamController<List<CardExample>> exampleCard = StreamController<List<CardExample>>();
  Stream<List<CardExample>> get getExampleCard => exampleCard.stream;
  StreamSink<List<CardExample>> get _getExample => exampleCard.sink;
  final _eventController = StreamController<BillingEvent>();
  Sink<BillingEvent> get eventSink => _eventController.sink;

  NewBillingBloc(){
    //_eventController.stream.listen(onData);
  }

  /*Future<void> onData(BillingEvent event) async {
    if(event is LoadData){
      List<CardExample> data = await _repository.fetchcard(0);
      _getExample.add(data);
      print('load data first');
    } else {
      List<CardExample> data = await _repository.fetchcard(0);
      print('more');
    }
  }*/

  retrieveExampleData(int start) async {
    print('fetchDataBilling: run');
    //List<CardExample> data = await _repository.fetchcard(start);
    //print('fetchDataBilling: result $data');
    //_getExample.add(data);
    print('fetchDataBilling: finish');
    //exampleCard.close();
  }

  void dispose(){
    exampleCard.close();
    _eventController.close();
  }
}
