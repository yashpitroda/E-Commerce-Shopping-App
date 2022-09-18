import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';
import 'dart:convert';

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

  Future<void> fatchAndsetOrders() async {
    final url = Uri.parse(
        'https://shop-app-f1d6e-default-rtdb.firebaseio.com/Order.json');
    final response = await http.get(url);
    print(response.body);
    if (response.body == 'null') {
      //response.body has no value but as a string 'null'
      //mean firebse is empty
      print('its retruns');
      return;
    }
    final List<OrderItem> loadedOrderslist = [];
    final extractedOrderData =
        json.decode(response.body) as Map<String, dynamic>;
    // if (extractedOrderData == 'null') {
    //   return;
    // }
    extractedOrderData.forEach(
      (firebasekey, orderdata) {
        //orderdata is map which is on firebase
        loadedOrderslist.add(
          OrderItem(
            id: firebasekey,
            amount: orderdata['amount'].toDouble(),
            products: (orderdata['orderProductList'] as List)
                .map((element) => CartItem(
                    id: element['id'],
                    title: element['title'],
                    quantity: element['quantity'],
                    price: element['price'].toDouble()))
                .toList(),
            dateTime: DateTime.parse(
              orderdata['dateTime'],
            ),
          ),
        );
      },
    );
    // _ordersList = loadedOrderslist;
    _ordersList = loadedOrderslist.reversed.toList(); //reverse list//last order show frist
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-f1d6e-default-rtdb.firebaseio.com/Order.json');
    final timestap = DateTime.now();
    final responce = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime':
              timestap.toIso8601String(), //batter sting formate for datetime
          'orderProductList': cartProducts //orderProductList is list of map
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));
    print(responce.body);
    _ordersList.insert(
        0,
        OrderItem(
            id: json.decode(responce.body)['name'], //firebase id
            amount: total,
            products: cartProducts,
            dateTime: timestap));

    notifyListeners();
  }
}
