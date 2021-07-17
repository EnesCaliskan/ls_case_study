import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'category_screen.dart';

class FruitScreen extends StatelessWidget {
  final Kategori category;
  FruitScreen({key, required this.category}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.title),),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Text('Meyve'),
      ),
    );
  }
}