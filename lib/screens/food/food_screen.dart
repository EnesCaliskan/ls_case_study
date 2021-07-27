import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ls_case_study/models/food.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ls_case_study/providers/food_provider.dart';
import 'package:ls_case_study/screens/cart/cart_screen.dart';
import 'package:ls_case_study/assets/constants.dart';
import 'package:ls_case_study/widgets/FoodScreenWidgets.dart';
import 'package:provider/provider.dart';

class FoodScreen extends StatefulWidget {
  final List<Food> foods;
  final String selectedFood;
  const FoodScreen({Key? key, required this.foods, required this.selectedFood})
      : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final _random = new Random();
  @override

  initState(){
    super.initState();
  }

  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context);

    for (int i = 0; i < widget.foods.length; i++) {
      if (widget.selectedFood == widget.foods[i].name) {
        foodProvider.setSelectedFoodName(widget.foods[i].name);
        foodProvider.setSelectedPrice(widget.foods[i].price);
        foodProvider.setSelectedImgUrl(widget.foods[i].imageURL);
        foodProvider.setSelectedDesc(widget.foods[i].description);
        foodProvider.setSelectedCategory(widget.foods[i].category);
      }
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReturnBackButton(),
                      IconButton(
                          icon: Icon(Icons.shopping_cart, color: kBlack),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => CartScreen(),),);
                          }
                      ),
                    ],
                  ),
                  ReturnFoodName(),
                ],
              ),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: gradients[_random.nextInt(gradients.length)],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.width * 1.3,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReturnFavoriteButton(),
                  ReturnDescriptionPadding(),
                  ReturnBasketButton(),
                ],
              ),
            ),
          ),
          ReturnFoodImage(),
        ],
      ),
    );


  }
}

