import 'package:flutter/material.dart';
import 'package:myrscm/constant.dart';
import 'package:myrscm/src/view/widget/form_input.dart';
class AppointmentFormPage extends StatefulWidget {
  @override
  _AppointmentFormPageState createState() => _AppointmentFormPageState();
}

class _AppointmentFormPageState extends State<AppointmentFormPage> {

  final _mrn = TextEditingController();
  final _name = TextEditingController();
  final _birthdate = TextEditingController();
  final _address = TextEditingController();
  final _visitDate = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();

  final _formAddAppointment = GlobalKey<FormState>();

  @override
  void initState() {

    _mrn.text = "4461002";
    _name.text = "Kemal Wibisono";
    _birthdate.text = "25 Februari 1993";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Buat Perjanjian'),
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('Semua pelayanan Poli pada hari libur / tanggal merah akan tutup. Harap tidak membuat perjanjian. Setelah membuat permintaan janji, kami akan menghubungi Anda untuk konfirmasi selanjutnya sesegera mungkin.',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 0.5), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                    ),
                    padding: EdgeInsets.only(left: 40, top: 20, right: 40),
                    child: Form(
                      key: _formAddAppointment,
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: <Widget>[
                            //FormInputWidget(label: "Nomor Rekam Medik", controller: _mrn, isPassword: false),
                            //FormInputWidget(label: "Nama", controller: _name, isPassword: false),
                            //FormInputWidget(label: "Tanggal Lahir", controller: _birthdate, isPassword: false),
                            //FormInputWidget(label: "Alamat", controller: _address, isPassword: false),
                            FormInputWidget(label: "Email", controller: _email, isPassword: false),
                            FormInputWidget(label: "Tanggal Kunjungan", controller: _visitDate, isPassword: false),
                            FormInputWidget(label: "Poli / Klinik Tujuan", controller: _visitDate, isPassword: false),
                            FormInputWidget(label: "Dokter DPJP", controller: _visitDate, isPassword: false),
                            FormInputWidget(label: "Cara Bayar", controller: _visitDate, isPassword: false),
                            //FormInputWidget(label: "No. Telp", controller: _phone, isPassword: false),

                            InkWell(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: defaultAppbarColor,
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Text(
                                  'Buat',
                                  style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: _showMyDialog,
                            ),
                          ]
                      ),
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
          title: Text('Konfirmasi', style: TextStyle(color: defaultAppbarColor, fontWeight: FontWeight.w700)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah anda yakin data perjanjian yang anda masukan sudah benar?',
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
                  'Batal',
                  style: TextStyle(color: defaultAppbarColor, fontWeight: FontWeight.w500)
              ),
              onPressed: () {
                print('cancel clicked');
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                  'Lanjutkan',
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
