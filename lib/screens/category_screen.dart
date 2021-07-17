import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'vegetable_screen.dart';
import 'package:ls_case_study/models/food.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Kategori {
  final String title;

  Kategori(this.title);
}

class CategoryScreen extends StatelessWidget {
  final List<Kategori> categories;

  CategoryScreen({key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categories[index].title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VegetableScreen( // vegetable screen yerine secili kategorinin sayfasina atmali
                      category: categories[index],
                    ),
                    settings: RouteSettings(arguments: categories[index]),
                  ),
                );
              },
            );
          }),
    );
  }
}
