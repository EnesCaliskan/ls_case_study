import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'package:grouped_list/grouped_list.dart';
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
      .get(Uri.parse('C:\Users\EnesCaliskan\AndroidStudioProjects\ls_case_study\lib\data.json'));

  return compute(parseFoods, response.body);
}


class VegetableScreen extends StatelessWidget {
  final Kategori category;
  VegetableScreen({key, required this.category}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.title),),
      body: FutureBuilder<List<Food>>(
        future: fetchFoods(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? FoodList(foods: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        }
      ),
    );
    
  }
}

class FoodList extends StatelessWidget {
  final List<Food> foods;
  const FoodList({key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foods[index].name),
          );
        });
  }
}
