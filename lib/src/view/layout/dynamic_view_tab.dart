import 'package:myrscm/src/bloc/billing_bloc.dart';
import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/model/card_example_model.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/model/tab_model.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/screen/page_no_data.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/widget/card_detail_billing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/src/view/widget/widget_no_data.dart';

class DynamicViewTab extends StatefulWidget {

  final TabModel view;
  DynamicViewTab(this.view);

  @override
  _DynamicViewTabState createState() => _DynamicViewTabState(view);
}

class _DynamicViewTabState extends State<DynamicViewTab> {
  
  final TabModel view;
  final bloc = BillingBloc();
  bool isClicked = false;
  bool isFinal = false;
  List<CardExample> listData =[];
  bool isGetPref = false;
  PatientModel patient;
  
  _DynamicViewTabState(this.view);

  @override
  void initState() {
    listData = view.data;
    //check user session
    MySharedPreferences sp = MySharedPreferences(context: context);
    sp.getPatientIsLogin().then((isLogin){
      print('initState: $isLogin');

      //if user not login, clear preferences and remove preferences data
      if(!isLogin) sp.clearData();
      else {

        //if user is login but no data, clear preferences and remove
        sp.getPatientPref().then((patient){
          if(patient == null) sp.clearData();
          else {
            this.patient = patient;
            setState(() => isGetPref = true);
          }
        });

      }
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isGetPref == true ? generateCard() : PageLoading();
  }

  Widget generateCard(){
    List<Widget> list = new List<Widget>();
    print('print generateCard: data length ${listData.length}');
    if(listData.length > 0){

      print('generateCard: show ${listData.length} card');
      for(var i = 0; i < listData.length; i++) list.add(WidgetCardDetailBilling(listData[i]));
      if(isClicked){
        list.add(StreamBuilder(
            initialData: bloc.retrieveMoreDataBilling(patient.patientId,view.id,listData.length),
            stream: bloc.getmoreData,
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.active){

                //if data empty
                if(!snapshot.hasData) {
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    setState(() {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Tidak ada lagi data detail tagihan."),
                      ));
                      isClicked = false;
                    });
                  });
                }

                //if data contains error
                if(snapshot.hasError){
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    setState(() {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(snapshot.error.toString()),
                      ));
                      isClicked = false;
                    });
                  });
                }

                //if data success
                if(snapshot.hasData && snapshot != null){
                  BillingDataMoreModel dataMoreModel = snapshot.data;
                  //filter data for because there is some data in array and ind result
                  List<CardExample> filterData = [];
                  for(int i = 0; i < dataMoreModel.data.length; i++){
                    CardExample row = dataMoreModel.data[i];
                    bool isContain = false;
                    for(int j = 0; j < listData.length; j++){
                      CardExample source = listData[j];
                      if(source.id == row.id){
                        isContain = true;
                        break;
                      }
                    }
                    if(!isContain) filterData.add(row);
                  }
                  //!filter data for because there is some data in array and ind result
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    setState(() {
                      if(filterData.length == 0) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Data sudah semua ditampilkan"),
                        ));
                        print('udah abis datanya');
                        isClicked = false;
                        isFinal = true;
                      } else {
                        listData.addAll(filterData);
                        isClicked = false;
                      }
                    });
                  });
                }
                return Container();
              } else return PageLoading();
            }
        ));
      } else {
        //jika isi data lebih besar dari 4
        if(!isFinal && listData.length > 4){
          list.add(FlatButton.icon(
            padding: EdgeInsets.all(20),
              onPressed: (){
                print('${view.id} - with size ${view.data.length}');
                setState(() {
                  isClicked = true;
                });
              },
              icon: Icon(Icons.expand_more),
              label: Text('More')
          ));
        } else list.add(Container());
      }

      print('generateCard: done');
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index){
          return list[index];
        },
        physics: BouncingScrollPhysics(),
      );


    } else {
      print('generateCard: return page no data');
      return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: WidgetNoData(
              title: 'Data tidak ditemukan',
              subtitle: 'Data detail tagihan di kelompok layanan ${view.content} tidak ditemukan',
              isBack: false,
          )
      );
    }

  }
}
