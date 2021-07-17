import "package:http/http.dart";
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Food{

    final int id;
    final String name;
    final int quantity;
    final String category;
    final int price;
    final String imageURL;

    Food({
      required this.id,
      required this.name,
      required this.quantity,
      required this.price,
      required this.category,
      required this.imageURL,
    });


    factory Food.fromJson(Map<String, dynamic> json) {
      return Food(
        id: json['id'] as int,
        name: json['name'] as String,
        quantity: json["quantity"] as int,
        price: json["price"] as int,
        category: json["category"] as String,
        imageURL: json['imageURL'] as String,
      );
    }




}