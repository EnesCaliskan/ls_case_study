import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ls_case_study/screens/food/food_screen.dart';
import 'package:ls_case_study/models/food.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ls_case_study/repository/foodFetcher.dart';
import 'package:http/http.dart' as http;
import 'package:ls_case_study/assets/constants.dart';

class VegetableScreen extends StatefulWidget {
  final String selectedCategory;
  VegetableScreen({key, required this.selectedCategory}) : super(key: key);

  @override
  State<VegetableScreen> createState() => _VegetableScreenState();
}

class _VegetableScreenState extends State<VegetableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Food>>(
          future: fetchFoods(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? FoodList(
                    foods: snapshot.data!,
                    selectedCat: widget.selectedCategory,
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
  final _random = new Random();
  String _selectedFood = "";
  @override
  Widget build(BuildContext context) {
    List foodList = []; //filtering the foods from the categories
    for (int i = 0; i < widget.foods.length; i++) {
      if (widget.selectedCat == widget.foods[i].category) {
        foodList.add(widget.foods[i].name);
      }
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BackButton(
                color: kBlack,
              ),
              Text(
                widget.selectedCat,
                style: TextStyle(
                    fontSize: 20.0, color: kBlack, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: gradients[_random.nextInt(gradients.length)],
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        foodList[index],
                        style: TextStyle(
                            fontSize: 18.0,
                            color: kBlack,
                            fontWeight: FontWeight.w600),
                      ),
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
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
