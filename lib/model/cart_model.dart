import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {

  final List _shopItems = const [
    ["Aguacate", "76.15", "lib/images/avocado.png", Colors.green],
    ["Sandia", "12.70", "lib/images/watermelon.png", Colors.red],
    ["Platano", "22.90", "lib/images/banana.png", Colors.orange],
    ["Pollo", "42.92", "lib/images/chicken.png", Colors.brown],
    ["Piña", "36.40", "lib/images/pineapple.png", Colors.green],
    ["Jitomate", "15.90", "lib/images/tomato.png", Colors.red],
    ["Mango", "30.00", "lib/images/mango.png", Colors.orangeAccent],
    ["Agua", "15.00", "lib/images/water.png", Colors.blue],
  ];

  List _cartItems = [];
  get cartItems => _cartItems;
  get shopItems => _shopItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void removeAllItems(){
    _cartItems = [];
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}