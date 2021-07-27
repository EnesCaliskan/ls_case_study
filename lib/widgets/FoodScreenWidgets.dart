import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ls_case_study/assets/constants.dart';
import 'package:ls_case_study/db/boxes.dart';
import 'package:ls_case_study/models/cart.dart';
import 'package:ls_case_study/models/favorites.dart';
import 'package:ls_case_study/providers/food_provider.dart';
import 'package:provider/provider.dart';

Future addCartItem(String? name, String? category, int? price, String? imageUrl) async {
  final cartItem = Cart()
    ..name = name!
    ..category = category!
    ..price = price!
    ..imageUrl = imageUrl ?? "";

  final box = Boxes.getCart();
  box.put(name, cartItem);
}

Future addFavorites(String name, String category) async {
  final favorite = Favorites()
    ..name = name
    ..category = category;
  final box = Boxes.getFavorites();
  box.put(name, favorite);
}

Future clearSelected(String name) async {
  final box = Boxes.getFavorites();
  box.delete(name);
}

class ReturnDescriptionPadding extends StatelessWidget {
  const ReturnDescriptionPadding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(30.0),
          height: MediaQuery.of(context).size.width * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: kBlack,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            foodProvider.selectedDesc,
            style: TextStyle(fontSize: 18.0, color: kBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class ReturnPriceTag extends StatelessWidget {
  const ReturnPriceTag({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price',
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            '₺' +
                foodProvider.selectedPrice
                    .toString(),
            style: TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}

class ReturnBasketButton extends StatefulWidget {
  const ReturnBasketButton({Key? key}) : super(key: key);

  @override
  _ReturnBasketButtonState createState() => _ReturnBasketButtonState();
}

class _ReturnBasketButtonState extends State<ReturnBasketButton> {
  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context);
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReturnPriceTag(),
          SizedBox(
            height: 50.0,
            width: 150.0,
            child: TextButton(
              onPressed: () {
                WidgetsBinding.instance!.addPostFrameCallback((_){
                  setState(() {
                    foodProvider.setBasketClicked(!(foodProvider.basketClicked),);
                    addCartItem(
                        foodProvider.selectedFoodName,
                        foodProvider.selectedCategory,
                        foodProvider.selectedPrice,
                        foodProvider.selectedImgURL
                    );
                  });
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    foodProvider.basketClicked ? Icons.check_rounded : Icons.shopping_basket,
                    color: foodProvider.basketClicked ? kYellow : kYellow,
                  ),
                  Text(
                    'Add to Basket',
                    style: TextStyle(color: kYellow, fontSize: 14.0, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(foodProvider.basketClicked ? Colors.green : kOrange),
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ReturnFavoriteButton extends StatefulWidget {
  const ReturnFavoriteButton({Key? key}) : super(key: key);
  @override
  _ReturnFavoriteButtonState createState() => _ReturnFavoriteButtonState();
}

class _ReturnFavoriteButtonState extends State<ReturnFavoriteButton> {
  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 80.0, left: 20.0, right: 180.0),
      child: Container(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  foodProvider.setAlreadySelected(!(foodProvider.alreadySelected));
                  if(foodProvider.alreadySelected){
                    addFavorites(foodProvider.selectedFoodName, foodProvider.selectedCategory);
                  }
                  else{
                    clearSelected(foodProvider.selectedFoodName);
                  }
                });
              },
              icon : Icon(
                foodProvider.alreadySelected ? Icons.favorite : Icons.favorite_border,
                color: foodProvider.alreadySelected ? Colors.red : null,
              ),
            ),
            Text(
              'Add to Favorites',
              style: TextStyle(fontSize: 18.0, color: kBlack, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class ReturnFoodImage extends StatefulWidget {
  const ReturnFoodImage({Key? key}) : super(key: key);

  @override
  _ReturnFoodImageState createState() => _ReturnFoodImageState();
}

class _ReturnFoodImageState extends State<ReturnFoodImage> {
  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context);
    return Align(
      alignment: Alignment(0.0, -0.4),
      child: CircleAvatar(
        backgroundImage: NetworkImage(foodProvider.selectedImgURL),
        backgroundColor: Colors.transparent,
        radius: 80.0,
      ),
    );
  }
}

class ReturnFoodName extends StatelessWidget {
  const ReturnFoodName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context);
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 20.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          foodProvider.selectedFoodName,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class ReturnBackButton extends StatelessWidget {
  const ReturnBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: kBlack,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}










