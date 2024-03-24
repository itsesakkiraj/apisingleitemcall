import 'package:apicalls/apicall.dart';
import 'package:flutter/cupertino.dart';

class ApiProvider extends ChangeNotifier {
  Apicall apicall = Apicall();

  Map<String, dynamic> userr = {};

  Future<void> getdata() async {
    try {
      userr = await apicall.fetchData();
      print("userr : $userr");
      notifyListeners();
    } catch (e) {
      throw Exception("error $e");
    }
  }
}
