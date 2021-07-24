import 'package:flutter/material.dart';
import 'food_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ls_case_study/models/favorites.dart';
import 'package:ls_case_study/models/boxes.dart';
import 'package:ls_case_study/assets/constants.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    Future clearFavorites() async {
      final box = Boxes.getFavorites();
      box.deleteAll(box.keys);
    }
    Future clearSelected(String name) async {
      final box = Boxes.getFavorites();
      box.delete(name);
    }

    Widget buildContent(List<Favorites> favorites) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 50.0, left: 20.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text('Favorites', style: TextStyle(fontSize: 20.0, color: kBlack, fontWeight: FontWeight.w700),),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${favorites[index].name}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: kBlack,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${favorites[index].category}',
                      style: TextStyle(color: kBlack),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red,),
                      onPressed: (){
                        setState(() {
                          clearSelected(favorites[index].name);
                        });
                      },
                    ),
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
                style: TextStyle(color: kBlack, fontSize: 14.0),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
        body: ValueListenableBuilder<Box<Favorites>>(
            valueListenable: Boxes.getFavorites().listenable(),
            builder: (context, box, _) {
              final favorites = box.values.toSet().toList().cast<Favorites>();
              return buildContent(favorites);
            }));
  }
}
