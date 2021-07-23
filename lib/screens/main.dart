import 'package:flutter/material.dart';
import 'package:ls_case_study/models/cart.dart';
import 'package:ls_case_study/screens/food_screen.dart';
import 'package:ls_case_study/screens/vegetable_screen.dart';
import 'category_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ls_case_study/models/favorites.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(FavoritesAdapter());
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox<Favorites>('favorites');
  await Hive.openBox<Cart>('cartItems');

  runApp(FoodApp());
}

class FoodApp extends StatefulWidget {
  @override
  State<FoodApp> createState() => _FoodAppState();
}

class _FoodAppState extends State<FoodApp> {
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;

  final List<Widget> tabs = [CategoryScreen(), FavoriteScreen(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme data will be added
      theme: ThemeData(),
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                _currentIndex == 0 ? 'Categories' : _currentIndex == 1 ? 'Favorites' : _currentIndex == 2 ? 'Basket' : '',
                style: TextStyle(fontSize: 18.0, color: kBlack),
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: onTappedBar,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Basket')
              ])),
    );
  }
}
