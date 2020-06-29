import 'package:myrscm/src/bloc/billing_bloc.dart';
import 'package:myrscm/src/connectivity/connectivity.dart';
import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/model/patient_model.dart';
import 'package:myrscm/src/screen/page_500.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/screen/page_no_data.dart';
import 'package:myrscm/src/shared_preferences/shared_preferences.dart';
import 'package:myrscm/src/view/layout/layout_billing.dart';
import 'package:myrscm/src/view/widget/widget_circular_progress.dart';
import 'package:flutter/material.dart';

class BillingPage extends StatefulWidget {
  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final bloc = BillingBloc();
  PatientModel patient;
  bool isLogin = false;
  bool isGetPref = false;

  @override
  void initState() {
    print('billing initState: run');

    //check user connectivity;
    MyConnectivity().getConnectivity().then((isConnect){

      //if user not connected to internet
      if(!isConnect) Navigator.popAndPushNamed(context, '/no_connection');
      else {

        //check user session
        MySharedPreferences sp = MySharedPreferences(context: context);
        sp = MySharedPreferences(context: context);
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

    print('billing build: run');
    return Scaffold(
      body: isGetPref == true ?
      /*StreamBuilder(
          initialData: bloc.fetchDataBilling(patient.patientId),
          stream: bloc.dataBilling,
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.active){

              //if error come from API
              if(snapshot.hasError){
                print(snapshot.error.toString());
                return Page500();
              }

              //if there is no data
              else if(!snapshot.hasData || snapshot.data == null){
                print(snapshot.error.toString());
                return PageNoData(title: "Data tidak ditemukan", subtitle: "Tagihan anda tidak ditemukan didalam sistem kami, harap coba lagi lain waktu.");
              }

              //default return generate widget
              else return generateView(snapshot.data);
            }
            //default run circular progress
            return Center(child: WidgetCircularProgress());
          })*/getData() : PageLoading()
    );
  }

  Widget getData(){
    return FutureBuilder<BillingModel>(
        future: bloc.getBilling(patient.patientId),
        builder:(context, snapshot){
          // if snapshot done
          if(snapshot.connectionState == ConnectionState.done){

            //if return api has error
            if(snapshot.hasError){
              print('getData : has error');
              //add callback
              WidgetsBinding.instance.addPostFrameCallback((_){
                Navigator.pushReplacementNamed(context,'/server_error');
              });
              return Container(child: Text(''));
            } else {
              //if snapshot has data
              if(snapshot.hasData){
                print('getData : success & has data');
                return generateView(snapshot.data);
              }
              //if snapshot has no data
              else {
                print('getData : has null');
                return PageNoData(title: 'Tidak ada tagihan', subtitle: 'Tidak ada data tagihan yang dikenakan kepada anda.');
              }
            }
          } else {
            print('getData connectionState: ${snapshot.connectionState}');
            return PageLoading();
          }
        }
    );
  }

  Widget generateView(data){
    return OrientationBuilder(builder: (context, orientation) {
      return VerticalLayoutBilling(data);
      //return MediaQuery.of(context).size.width > 500 ? HorizontalLayoutBilling(data) : VerticalLayoutBilling(data);
    });
  }
}