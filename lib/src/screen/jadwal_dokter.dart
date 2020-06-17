import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:myrscm/src/connectivity/connectivity.dart';
import 'package:myrscm/src/screen/page_loading.dart';

import '../../constant.dart';

/*class JadwalDokterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://www.rscm.co.id/index.php?XP_webview_menu=&pageid=254&title=Jadwal%20Dokter%20RSCM%20Kencana",
      appBar: new AppBar(
        title: new Text("Jadwal Dokter Kencana"),
        centerTitle: true,
        backgroundColor: defaultAppbarColor,
      ),
      ignoreSSLErrors: true,
    );
  }
}*/

class JadwalDokterPage extends StatefulWidget {
  @override
  _JadwalDokterPageState createState() => _JadwalDokterPageState();
}

class _JadwalDokterPageState extends State<JadwalDokterPage> {

  bool isLoading = false;

  @override
  void initState() {

    //check user connection
    MyConnectivity().getConnectivity().then((isConnect){
      if(!isConnect) Navigator.popAndPushNamed(context, '/no_connection');
      else setState(() => isLoading = true);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true ?
      WebviewScaffold(
      url: "https://www.rscm.co.id/index.php?XP_webview_menu=&pageid=254&title=Jadwal%20Dokter%20RSCM%20Kencana",
      appBar: new AppBar(
        title: new Text("Jadwal Dokter Kencana"),
        centerTitle: true,
        backgroundColor: defaultAppbarColor,
      ),
      ignoreSSLErrors: true,
    ) : PageLoading();
  }
}



