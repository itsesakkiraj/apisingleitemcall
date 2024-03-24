import 'dart:convert';

import 'package:http/http.dart' as http;

class Apicall {
  static const apiurl = "https://reqres.in/api/users/2";

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiurl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final responsedata = jsonData['data'] as Map<String, dynamic>;
      print(responsedata);
      return responsedata;
    } else {
      throw Exception("error while fetching data from api");
    }
  }
}
