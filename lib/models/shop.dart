import 'package:sushi_restaurant/models/food.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Food> _foodMenu = [
    Food(
        imagePath: 'lib/assets/salmon.png',
        name: 'Salmon Sushi',
        price: '21',
        rating: '4.9'),
    Food(
        imagePath: 'lib/assets/tuna.png',
        name: 'Tuna',
        price: '23',
        rating: '4.8'),
    Food(
        imagePath: 'lib/assets/sushi.png',
        name: 'Sushi',
        price: '17',
        rating: '4.3')
  ];

  //customer's cart
  List<Food> _cart = [];

  //getter methods
  List<Food> get foodMenu => _foodMenu;
  List<Food> get cart => _cart;

  //add to cart
  void addToCart(Food foodItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodItem);
    }
    notifyListeners();
  }

  //remove
  void removeFromCart(Food foodItem) {
    _cart.remove(foodItem);
    notifyListeners();
  }
}
