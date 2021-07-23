import 'package:flutter/material.dart';
import 'food_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ls_case_study/models/cart.dart';
import 'package:ls_case_study/models/boxes.dart';

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
    Future clearCartItems() async {
      final box = Boxes.getCart();
      box.deleteAll(box.keys);
    }

    Widget buildContent(List<Cart>? cartItems) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cartItems!.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Image.network('${cartItems[index].imageUrl}'),
                      ),
                      Column(
                        children: [
                          Text('${cartItems[index].name}'),
                          Text('${cartItems[index].category}'),
                        ],
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.delete),
                      ),
                    ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 50.0,
            width: 120.0,
            child: TextButton(
              onPressed: () {
                clearCartItems();
              },
              child: Text(
                'Delete All Cart Items',
                style: TextStyle(color: kBlack),
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
