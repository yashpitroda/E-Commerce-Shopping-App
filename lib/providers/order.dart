import 'package:flutter/material.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _ordersList = [];

  List<OrderItem> get orders {
    return [..._ordersList];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _ordersList.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));

    notifyListeners();
  }
}
