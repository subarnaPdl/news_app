import 'package:connectivity/connectivity.dart';

class ConnectivityCheck {
  Future<bool> getConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }
}
