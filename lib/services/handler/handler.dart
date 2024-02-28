import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:virench_trial_task/services/handler/http_urls.dart';

class ApiHandler {
  static Future<http.Response> get({required String url}) async {
    debugPrint(url);
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json", 'Authorization': 'Bearer '},
    );
    return response;
  }

  static Future<http.Response> post(
      {required String url, required Map<String, dynamic> body}) async {
    debugPrint(url);
    debugPrint(body.toString());
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    return response;
  }

  static Future<http.Response> put(String url,
      {Map<String, dynamic>? body}) async {
    http.Response response = await http.put(Uri.parse(HttpUrl().baseUrl + url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    return response;
  }

  static Future<http.Response> delete(String url) async {
    http.Response response = await http.delete(
      Uri.parse(HttpUrl().baseUrl + url),
    );

    return response;
  }
}