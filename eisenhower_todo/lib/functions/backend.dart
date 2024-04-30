import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> sendData(text) async {
  var url = Uri.parse('http://127.0.0.1:5001/data');
  var response = await http.post(url, body: jsonEncode({'text': '$text'}), headers: {'Content-Type': 'application/json'});
  print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  return response.body;
}

Future<void> fetchData() async {
  var url = Uri.parse('http://127.0.0.1:5001/data');
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
