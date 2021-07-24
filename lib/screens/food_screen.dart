import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ls_case_study/models/favorites.dart';
import 'package:ls_case_study/models/foodFetcher.dart';
import 'package:flutter/foundation.dart';
import 'package:ls_case_study/models/food.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ls_case_study/screens/cart_screen.dart';
import 'package:ls_case_study/models/boxes.dart';
import 'package:ls_case_study/models/cart.dart';
import 'package:ls_case_study/assets/constants.dart';

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
  final _saved = <String>{};
  @override

  initState(){
    super.initState();
  }

  bool alreadySelected = false;
  bool basketClicked = false;

  Widget build(BuildContext context) {

    Future addFavorites(String name, String category) async {
      final favorite = Favorites()
        ..name = name
        ..category = category;
      final box = Boxes.getFavorites();
      box.put(name, favorite);
    }

    Future addCartItem(String? name, String? category, int? price, String? imageUrl) async {
      final cartItem = Cart()
        ..name = name!
        ..category = category!
        ..price = price!
        ..imageUrl = imageUrl ?? "";

      final box = Boxes.getCart();
      box.put(name, cartItem);
    }

    Future clearSelected(String name) async {
      final box = Boxes.getFavorites();
      box.delete(name);
    }

    int selectedPrice = 0;
    String? selectedImgURL = "";
    String selectedDesc = "";
    String selectedFoodName = "";
    String selectedCategory = "";

    for (int i = 0; i < widget.foods.length; i++) {
      if (widget.selectedFood == widget.foods[i].name) {
        selectedFoodName = widget.foods[i].name;
        selectedPrice = widget.foods[i].price;
        selectedImgURL = widget.foods[i].imageURL;
        selectedDesc = widget.foods[i].description;
        selectedCategory = widget.foods[i].category;
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
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: kBlack,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                          icon: Icon(Icons.shopping_cart, color: kBlack),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => CartScreen(),),);
                          }
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.selectedFood, // buraya yemek ismi gelicek
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
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
                //color: kOrange,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70.0, left: 20.0),
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                alreadySelected = !alreadySelected;
                                print(alreadySelected);
                                if(alreadySelected){
                                  addFavorites(selectedFoodName, selectedCategory);
                                }
                                else{
                                  clearSelected(selectedFoodName);
                                }
                              });
                            },
                            icon : Icon(
                              alreadySelected ? Icons.favorite : Icons.favorite_border,
                              color: alreadySelected ? Colors.red : null,
                            ),
                            // buraya favori ozelligi gelecek
                          ),
                          Text(
                            'Add to Favorites',
                            style: TextStyle(fontSize: 18.0, color: kBlack),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        height: MediaQuery.of(context).size.width * 0.6,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: kBlack,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          selectedDesc, // buraya aciklama gelicek
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Text(
                                '₺' +
                                    selectedPrice
                                        .toString(), // buraya fiyat gelicek
                                style: TextStyle(fontSize: 24.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                          width: 150.0,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                basketClicked = !basketClicked;
                                addCartItem(selectedFoodName, selectedCategory, selectedPrice, selectedImgURL);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  basketClicked ? Icons.check_rounded : Icons.shopping_basket,
                                  color: basketClicked ? kYellow : kYellow,
                                ),
                                Text(
                                  'Add to Basket',
                                  style: TextStyle(color: kYellow),
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(basketClicked ? Colors.green : kOrange),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.4),
            child: CircleAvatar(
              backgroundImage: NetworkImage(selectedImgURL!),
              backgroundColor: Colors.transparent,
              radius: 80.0,
            ),
          ),
        ],
      ),
    );


  }
}

