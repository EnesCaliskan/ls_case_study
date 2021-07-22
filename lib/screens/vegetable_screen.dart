import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ls_case_study/screens/favorites_screen.dart';
import 'package:ls_case_study/screens/food_screen.dart';
import 'category_screen.dart';
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
      appBar: AppBar(
        title: Text(selectedCategory),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Food>>(
          future: fetchFoods(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? FoodList(
                    foods: snapshot.data!,
                    selectedCat: selectedCategory,
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class FoodList extends StatefulWidget {
  final List<Food> foods;
  final String selectedCat;

  const FoodList({key, required this.foods, required this.selectedCat})
      : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  String _selectedFood = "";
  @override
  Widget build(BuildContext context) {
    List foodList = []; //filtering the foods from the categories
    for (int i = 0; i < widget.foods.length; i++) {
      if (widget.selectedCat == widget.foods[i].category) {
        foodList.add(widget.foods[i].name);
      }
    }

    return ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foodList[index]),
            selected: foodList[index] == _selectedFood,
            onTap: () {
              setState(() {
                _selectedFood = foodList[index];
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodScreen(
                    foods: widget.foods,
                    selectedFood: _selectedFood,
                  ),
                ),
              );
            },
          );
        });
  }
}
