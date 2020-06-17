import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
class MyConnectivity{
  Future<bool> getConnectivity() async {

    print('Connectivity: getConnectivity run');
    bool isConnect = false;

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print('Connectivity: connect using mobile network');
      isConnect = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      print('Connectivity: connect using wifi');
      isConnect = true;
    } else print('Connectivity: no internet connection');

    return isConnect;
  }
}