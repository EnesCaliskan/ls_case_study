import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ls_case_study/models/foodFetcher.dart';
import 'package:flutter/foundation.dart';
import 'package:ls_case_study/models/food.dart';
import 'dart:async';
import 'dart:convert';
import 'package:ls_case_study/models/foodFetcher.dart';
import 'package:http/http.dart' as http;

Color kYellow = const Color(0xFFFFC529);
Color kOrange = const Color(0xFFFE724C);
Color kBlack = const Color(0xFF272D2F);
Color kGray = const Color(0xFFD7D7D7);

class FoodScreen extends StatelessWidget {
  final List<Food> foods;
  final String selectedFood;
  const FoodScreen({Key? key, required this.foods, required this.selectedFood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedPrice = 0;
    String selectedImgURL = "";
    String selectedDesc = "";

    for (int i = 0; i < foods.length; i++) {
      if (selectedFood == foods[i].name) {
        selectedPrice = foods[i].price;
        selectedImgURL = foods[i].imageURL;
        selectedDesc = foods[i].description;
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
                          onPressed: () {
                            Navigator.pop(context); // sepet sayfasina gidicek
                          }),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        selectedFood, // buraya yemek ismi gelicek
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kOrange,
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
                            onPressed: () {}, // buraya favori ozelligi gelecek
                            icon: Icon(Icons.favorite_border),
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
                          width: 120.0,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Add to Basket',
                              style: TextStyle(color: kBlack),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(kYellow),
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
              backgroundImage: NetworkImage(selectedImgURL),
              backgroundColor: Colors.transparent,
              radius: 80.0,
            ),
          ),
        ],
      ),
    );
  }
}
