import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'vegetable_screen.dart';
import 'package:ls_case_study/models/food.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ls_case_study/models/foodFetcher.dart';
import 'package:http/http.dart' as http;
import 'food_screen.dart';

class CategoryScreen extends StatefulWidget {

  CategoryScreen({key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Food>>(
          future: fetchFoods(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? CategoryList(foods: snapshot.data!)
                : Center(child: CircularProgressIndicator());
          });

  }
}

class CategoryList extends StatefulWidget {
  final List<Food> foods;

  const CategoryList({Key? key, required this.foods}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String _selectedIndex = "";
  @override
  Widget build(BuildContext context) {
    //getting rid of the duplicated categories
    List<String> categories = [];
    for (int i = 0; i < widget.foods.length; i++) {
      if (!(categories.contains(widget.foods[i].category))) {
        categories.add(widget.foods[i].category);
      }
    }

    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(7.0),
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0),),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [kOrange, kYellow],
                ),
              ),
              child: ListTile(
                title: Text(categories[index], style: TextStyle(fontSize: 18.0, color: kBlack),),
                selected: categories[index] == _selectedIndex,
                onTap: () {
                  setState(() { // sending the name of the selected category to food page
                    _selectedIndex = categories[index];
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VegetableScreen(selectedCategory: _selectedIndex)));
                },
              ),
            ),
          );
        });
  }
}
