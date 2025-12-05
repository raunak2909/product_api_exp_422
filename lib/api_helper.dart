import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {

  Future<dynamic> getAPI(
      {required String url, Map<String, String>? mHeaders}) async {
    var res = await http.get(Uri.parse(url), headers: mHeaders);
    if (res.statusCode == 200) {
      print(res.body);
      return jsonDecode(res.body);
    } else {
      return null;
    }
  }

}