import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../constant.dart';

class JadwalDokterPage extends StatelessWidget {
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
}


