import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite = false;

  Product({
    required this.title,
    required this.id,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });
  Future<void> toggleFavoriteStatus() async {
    final oldStatusOfFav = isFavorite;
    isFavorite = !isFavorite; 
    notifyListeners();
    final url = Uri.parse(
        'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products/$id.json');
    // 'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products/$id');
    //http is only give error response only in get and post method
    //other method like delte patch -- in this method we handle the exseption with the help of statusCode
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (response.statusCode >= 400) {
        //mean error ocur
        isFavorite = oldStatusOfFav;
        notifyListeners();
      }
    } catch (e) {
      isFavorite = oldStatusOfFav;
      notifyListeners();
    }
  }
}
