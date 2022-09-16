import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
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
  void toggleFavoriteStatus(){
  isFavorite=!isFavorite;
  notifyListeners();
}
}
