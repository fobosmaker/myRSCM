import 'package:myrscm/src/model/queue_model.dart';
import 'package:myrscm/src/provider/repository.dart';

class QueueBloc{

  final _repository = Repository();

  Future<QueueModel> getQueue(String patientId) async {
    print('getQueue:run');
    try{
      QueueModel data = await _repository.fetchQueue(patientId);
      print('getQueue: get data success!');
      return data;
    } catch (e){
      print('getQueue: error! $e');
      throw Exception(e);
    }

  }
}
