import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ls_case_study/models/favorites.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  Hive.registerAdapter(FavoritesAdapter());
  await Hive.openBox<Favorites>('favorites');

  runApp(FoodApp());
}

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme data will be added
      theme: ThemeData(),
      home: CategoryScreen(),
    );
  }
}
