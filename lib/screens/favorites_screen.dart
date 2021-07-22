import 'package:flutter/material.dart';
import 'food_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ls_case_study/models/favorites.dart';
import 'package:ls_case_study/models/boxes.dart';
import 'food_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override

  /*
  void dispose(){
    Hive.close();
    super.dispose();
  }
   */

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Future clearFavorites() async {
      final box = Boxes.getFavorites();
      box.deleteAll(box.keys);
    }

    Widget buildContent(List<Favorites> favorites) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${favorites[index].name}'),
                    subtitle: Text('${favorites[index].category}'),
                  );
                }),
          ),
          SizedBox(
            height: 50.0,
            width: 120.0,
            child: TextButton(
              onPressed: () {
                clearFavorites();
              },
              child: Text(
                'Clear Favorites',
                style: TextStyle(color: kBlack),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: ValueListenableBuilder<Box<Favorites>>(
            valueListenable: Boxes.getFavorites().listenable(),
            builder: (context, box, _) {
              final favorites = box.values.toSet().toList().cast<Favorites>();
              return buildContent(favorites);
            }));
  }
}
