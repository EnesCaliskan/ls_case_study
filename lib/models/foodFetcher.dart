import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ls_case_study/screens/category_screen.dart';
import 'package:ls_case_study/models/food.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Food> parseFoods(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Food>((json) => Food.fromJson(json)).toList();
}

Future<List<Food>> fetchFoods(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://my-json-server.typicode.com/EnesCaliskan/ls_case_study/foods'));

  return compute(parseFoods, response.body);
}