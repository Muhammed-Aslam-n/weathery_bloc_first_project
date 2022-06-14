import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService{
  final Connectivity _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();
  ConnectivityService(){
    _connectivity.onConnectivityChanged.listen((event) {connectivityStream.add(event);});
  }

}