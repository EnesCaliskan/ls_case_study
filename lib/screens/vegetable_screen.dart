import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ls_case_study/screens/food_screen.dart';
import 'category_screen.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ls_case_study/models/food.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ls_case_study/models/foodFetcher.dart';
import 'package:http/http.dart' as http;

class VegetableScreen extends StatelessWidget {
  final String selectedCategory;
  VegetableScreen({key, required this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedCategory)),
      body: FutureBuilder<List<Food>>(
        future: fetchFoods(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? FoodList(foods: snapshot.data!, selectedCat: selectedCategory,)
              : Center(child: CircularProgressIndicator());
        }
      ),
    );
    
  }
}

class FoodList extends StatelessWidget {
  final List<Food> foods;
  final String selectedCat;
  const FoodList({key, required this.foods, required this.selectedCat}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List foodList = []; //filtering the foods from the categories
    for(int i=0;i<foods.length;i++) {
      if(selectedCat == foods[i].category){
        foodList.add(foods[i].name);
      }
    }

    return ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foodList[index]),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FoodScreen()));
            },
          );
        });
  }
}
