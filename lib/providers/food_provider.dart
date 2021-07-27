import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodProvider with ChangeNotifier{
  late String _selectedFoodName;
  late String _selectedCategory;
  late int _selectedPrice;
  late String _selectedImgURL;
  late bool _basketClicked;
  late String _selectedDesc;
  late bool _alreadySelected;

  FoodProvider(){
    _selectedFoodName = '';
    _selectedCategory = '';
    _selectedPrice = 0;
    _selectedImgURL = '';
    _basketClicked = false;
    _selectedDesc = '';
    _alreadySelected = false;
  }


  //getters
  String get selectedCategory => _selectedCategory;
  String get selectedFoodName => _selectedFoodName;
  int get selectedPrice => _selectedPrice;
  String get selectedImgURL => _selectedImgURL;
  bool get basketClicked => _basketClicked;
  String get selectedDesc => _selectedDesc;
  bool get alreadySelected => _alreadySelected;

  //setters
  void setSelectedCategory(String selectedCategory){
    _selectedCategory = selectedCategory;
    notifyListeners();
  }

  void setSelectedFoodName(String selectedFoodName){
    _selectedFoodName = selectedFoodName;
    notifyListeners();
  }

  void setSelectedPrice(int selectedPrice){
    _selectedPrice = selectedPrice;
    notifyListeners();
  }

  void setSelectedImgUrl(String selectedImgUrl){
    _selectedImgURL = selectedImgUrl;
    notifyListeners();
  }

  void setBasketClicked(bool basketClicked){
    _basketClicked = basketClicked;
    notifyListeners();
  }

  void setSelectedDesc(String selectedDesc){
    _selectedDesc = selectedDesc;
    notifyListeners();
  }

  void setAlreadySelected(bool alreadySelected){
    _alreadySelected = alreadySelected;
    notifyListeners();
  }



}