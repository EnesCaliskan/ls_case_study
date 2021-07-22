import 'package:hive/hive.dart';
import 'package:ls_case_study/models/favorites.dart';

class Boxes{
  static Box<Favorites> getFavorites() =>
    Hive.box<Favorites>('favorites');
}