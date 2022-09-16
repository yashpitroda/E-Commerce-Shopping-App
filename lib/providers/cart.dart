import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItemMap = {}; //change to cartitemmap

  Map<String, CartItem> get cartItemMap {
    return {..._cartItemMap};
  }

  int get itemCount {
    print(_cartItemMap);
    return _cartItemMap == null ? 0 : _cartItemMap.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItemMap.forEach((key, value) {
      total += (value.price * value.quantity);
    });
    return total;
  }

  void addItem(String productId, double productPrice, String productTitle) {
    if (_cartItemMap.containsKey(productId)) {
      //change quantity

      //add item in map -- .update(key,object)
      //add item in list -- .insert(key,object)
      //
      _cartItemMap.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _cartItemMap.putIfAbsent(
          productId, //if this pid
          () => CartItem(
                id: DateTime.now().toString(),
                title: productTitle,
                quantity: 1,
                price: productPrice,
              ));
    }
    notifyListeners();
  }

  void removeItem(String pid) {
    _cartItemMap.remove(pid);
    notifyListeners();
  }

  void removeRecentlyAddedSingleItem(String pid) {
    if (_cartItemMap.containsKey(pid) == false) {
      // pid item is int exist in_cartItemMap
      return;
    } else {
      //if pid is exiset in _cartItemMap
      //then only edit if  qyntity is more then 1 //decrese constity by 1
      if (_cartItemMap[pid]!.quantity > 1) {
        _cartItemMap.update(
            pid,
            (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price));
      } else {
        //if quntity is 1 then remove full item
        _cartItemMap.remove(pid);
      }
    }
    notifyListeners();
  }

  void clear() {
    _cartItemMap = {};
    notifyListeners();
  }
}
