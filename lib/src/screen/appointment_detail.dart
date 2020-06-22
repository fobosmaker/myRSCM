import 'package:flutter/material.dart';
import 'package:myrscm/constant.dart';
import 'package:myrscm/src/view/widget/column_detail_perjanjian.dart';
class AppointmentDetailPage extends StatefulWidget {
  @override
  _AppointmentDetailPageState createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail Perjanjian'),
        backgroundColor: defaultAppbarColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: defaultAppbarColor
        ),
        child:  SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text('Silahkan lakukan check in sesuai jadwal pelayanan poliklinik. Tanda bukti perjanjian harap ditujukan kepada petugas loket perjanjian di Lobi Utama RSCM.',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                        WidgetColumnDetailPerjanjian("Perjanjian ID", "11817096"),
                        WidgetColumnDetailPerjanjian("Tanggal Kunjungan","12 Januari 2021"),
                        WidgetColumnDetailPerjanjian("Klinik/Poli","URJT - Poli Gizi"),
                        WidgetColumnDetailPerjanjian("No. Rekam Medik","4461002"),
                        WidgetColumnDetailPerjanjian("Dokter DPJP","Dokter yang bertugas"),
                        InkWell(
                          onTap: _showMyDialog,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.red[600],
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text(
                              'Batal',
                              style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          title: Text('Batal Perjanjian', style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.w700)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah anda yakin ingin membatalkan perjanjian?',
                    style: TextStyle(
                        fontWeight: FontWeight.w300
                    )
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  'Kembali',
                  style: TextStyle(color: defaultAppbarColor, fontWeight: FontWeight.w500)
              ),
              onPressed: () {
                print('cancel clicked');
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                  'Batalkan',
                  style: TextStyle(color: defaultAppbarColor, fontWeight: FontWeight.w500)
              ),
              onPressed: () {
                print('ya clicked');
                Navigator.of(context).pushNamedAndRemoveUntil('/appointment', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
