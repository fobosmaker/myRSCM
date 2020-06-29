import 'dart:async';

import 'package:myrscm/src/model/list_data_model.dart';
import 'package:myrscm/src/provider/repository.dart';

class AppointmentBloc{
  final _repository = Repository();

  //Get List Poli
  final listPoliController = StreamController<List<DefaultRowModel>>.broadcast();
  Stream<List<DefaultRowModel>> get dataListPoli => listPoliController.stream;
  StreamSink<List<DefaultRowModel>> get _inDataListPoli => listPoliController.sink;
  fetchListDataPoli() async {
    print('fetchListPoli: run');
    try{
      List<DefaultRowModel> data = await _repository.fetchPoli();
      print('fetchListPoli: result ${data.length}');
      _inDataListPoli.add(data);
    } catch(e) {
      print('fetchListPoli: result error');
      _inDataListPoli.addError(e);
    }
    print('fetchListPoli: finish');
  }

  //Get List Jadwal Dokter
  final listJadwalDokterController = StreamController<List<DefaultRowModel>>.broadcast();
  Stream<List<DefaultRowModel>> get dataListJadwalDokter => listJadwalDokterController.stream;
  StreamSink<List<DefaultRowModel>> get _inDataListJadwalDokter => listJadwalDokterController.sink;
  fetchListDataJadwalDokter(String date, String poliId) async {
    print('fetchListJadwalDokter: run');
    try{
      List<DefaultRowModel> data = await _repository.fetchJadwalDokter(date, poliId);
      print('fetchListJadwalDokter result ${data.toString()}');
      for(int i = 0; i < data.length; i++){
        DefaultRowModel row = data[i];
        print(row.content);
      }
      _inDataListJadwalDokter.add(data);
    } catch(e) {
      print('fetchListJadwalDokter: result error');
      _inDataListJadwalDokter.addError(e);
    }
    print('fetchListJadwalDokter: finish');
  }

  dispose(){
    listPoliController.close();
    listJadwalDokterController.close();
  }
}