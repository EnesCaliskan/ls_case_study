import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ls_case_study/models/cart.dart';
import 'package:ls_case_study/db/boxes.dart';
import 'package:ls_case_study/assets/constants.dart';
import 'package:ls_case_study/providers/food_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future clearCart() async {
      final box = Boxes.getCart();
      box.deleteAll(box.keys);
    }

    Future clearSelected(String name) async {
      final box = Boxes.getCart();
      box.delete(name);
    }

    Widget buildContent(List<Cart>? cartItems) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              BackButton(color: kBlack,),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Basket', style: TextStyle(fontSize: 20.0, color: kBlack, fontWeight: FontWeight.w700),),
              ),
            ],),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cartItems!.length,
                itemBuilder: (context, index) {
                  print(cartItems[index].price);
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kOrange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      height: 100.0,
                      width: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(cartItems[index].imageUrl),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${cartItems[index].name}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),),
                            Text('${cartItems[index].category}', style: TextStyle(fontSize: 16.0),),
                            Text('₺ ${cartItems[index].price}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),),
                          ],
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              clearSelected(cartItems[index].name);
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 50.0,
            width: 120.0,
            child: TextButton(
              onPressed: () {
                clearCart();
              },
              child: Text(
                'Clear Cart',
                style: TextStyle(color: kBlack, fontSize: 14.0),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
        body: ValueListenableBuilder<Box<Cart>>(
            valueListenable: Boxes.getCart().listenable(),
            builder: (context, box, _) {
              final cartItems = box.values.toSet().toList().cast<Cart>();
              return buildContent(cartItems);
            }));

  }




}
