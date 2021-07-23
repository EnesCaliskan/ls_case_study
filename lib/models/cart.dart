import 'package:hive/hive.dart';
part 'cart.g.dart';


@HiveType(typeId : 1)
class Cart{
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String category;

  @HiveField(2)
  late int price;

  @HiveField(3)
  late String imageUrl;

}