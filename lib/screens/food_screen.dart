import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Color kYellow = const Color(0xFFFFC529);
Color kOrange = const Color(0xFFFE724C);
Color kBlack = const Color(0xFF272D2F);
Color kGray = const Color(0xFFD7D7D7);

class FoodScreen extends StatelessWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                          icon: Icon(Icons.shopping_cart, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context); // sepet sayfasina gidicek
                          }),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Yemek ismi PlaceHolder', // buraya yemek ismi gelicek
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kOrange,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 500.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 130.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                        ),
                        child: Text(
                          'description', // buraya aciklama gelicek
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Text(
                                'priceholder', // buraya fiyat gelicek
                                style: TextStyle(fontSize: 24.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                          width: 120.0,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Add to Basket',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(kYellow),
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
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.4),
            child: CircleAvatar(
              // buraya yemegin resmi gelecek
              radius: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
