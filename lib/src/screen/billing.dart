import 'package:myrscm/src/bloc/billing_bloc.dart';
import 'package:myrscm/src/screen/page_500.dart';
import 'package:myrscm/src/screen/page_loading.dart';
import 'package:myrscm/src/screen/page_no_data.dart';
import 'package:myrscm/src/screen/shared_preferences.dart';
import 'package:myrscm/src/view/layout/layout_billing.dart';
import 'package:myrscm/src/view/widget/widget_circular_progress.dart';
import 'package:flutter/material.dart';

class BillingPage extends StatefulWidget {
  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final bloc = BillingBloc();
  String patientId;
  bool isLogin = false;
  bool isGetPref = false;

  @override
  void initState() {
    print('billing initState: run');
    //if user login
    MySharedPreferences sp = MySharedPreferences(context: context);
    sp.getPatientIsLogin().then((isLogin){
      print('initState: $isLogin');
      if(isLogin){
        sp.getPatientId().then((patientId){
          print('initstate: $patientId');
          if(patientId != null){
            this.patientId = patientId;
            setState(() => isGetPref = true);
          } else sp.clearData();
        });
      } else sp.clearData();
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Future<Null> refresh() async {
    //initState();
    print('refresh run');
  }

  @override
  Widget build(BuildContext context) {

    print('billing build: run');
    return Scaffold(
      body: isGetPref == true ?
      StreamBuilder(
          initialData: bloc.fetchDataBilling(patientId),
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
              else {
                return generateWidget(snapshot.data);
              }
            }
            //default run circular progress
            return Center(child: WidgetCircularProgress());
          }) : PageLoading()
    );
  }

  Widget generateWidget(data){
    return OrientationBuilder(builder: (context, orientation) {
      return VerticalLayoutBilling(data);
      //return MediaQuery.of(context).size.width > 500 ? HorizontalLayoutBilling(data) : VerticalLayoutBilling(data);
    });
  }
}