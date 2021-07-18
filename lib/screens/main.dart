import 'package:flutter/material.dart';
import 'category_screen.dart';

final names = ['cat1', 'cat2', 'cat3', 'cat4'];

void main() => runApp(FoodApp());

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme data will be added
      home: CategoryScreen(),
    );
  }
}
