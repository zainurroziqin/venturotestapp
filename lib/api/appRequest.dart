import 'dart:convert';
import 'package:http/http.dart' as http;

class AppRequest {
  static Future<Map?> gets(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> post(String url, String body) async {
    try {
      var response = await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> cancel(String url) async {
    try {
      var response = await http.post(Uri.parse(url));

      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      return null;
    }
  }
}