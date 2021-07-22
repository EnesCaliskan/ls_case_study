import 'package:hive/hive.dart';

part 'favorites.g.dart';

@HiveType(typeId : 0)
class Favorites{
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String category;

}