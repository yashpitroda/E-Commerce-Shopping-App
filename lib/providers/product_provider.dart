import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  //ChangeNotifier is a widget which astablis comueniication b/w penal with the help of contex
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      isFavorite: false,
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      isFavorite: false,
    ),
  ];
  // var _showFavoritesOnly = false;
  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) {
      return element
          .isFavorite; //if it is element.isFavorite true then it will retrun
    }).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) {
      return element.id == id;
    });
  }

  // void showFavoritesOnlyFunction() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAllFunction() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
//whithout async
//   Future<void> addProduct(Product prdct) {
//     // final url = Uri.parse(
//     //     'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products'); //this time catcherror will run
//     final url = Uri.parse(
//         'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products.json'); //products.json - is a node
//     return http
//         .post(url,
//             body: json.encode({
//               'title': prdct.title,
//               'description': prdct.description,
//               'imageUrl': prdct.imageUrl,
//               'price': prdct.price,
//               'imageUrl': prdct.imageUrl,
//               'isFavorite': prdct.isFavorite,
//               //first complete this post work after theat then will be elecute
//             }))
//         .catchError((error) {
//       print(error);
//       throw error;

//     }).then((response) {
//       //above post request is complete then this then fuction will elecute
//       //so when post request is done then only  we add a object to list
//       print(response.body); //key id//print as map
//       print(json.decode(response.body)); //it contians key id
//       //newproduct is not add indetly //when push request is complete then this will added in to productlist
//       final newproduct = Product(
//         id: json.decode(response.body)['name'], //
//         title: prdct.title,
//         description: prdct.description,
//         imageUrl: prdct.imageUrl,
//         price: prdct.price,
//         isFavorite: prdct.isFavorite,
//       );
//       print('info:${newproduct.id}');
//       _items.add(newproduct); //insert at last
//       //or
//       // _items.insert(0, newproduct); //if we want to insert product at indext =
//       notifyListeners();
//     }); //header is nothing but meta data about request
// //body mean main data which is atech with request
// // /JSON: javaScript object notation //dataFormate

// //without firebase
//     // final newproduct = Product(
//     //   // id: json.decode(response.body)['name'],//
//     //   id: DateTime.now().toString(),
//     //   title: prdct.title,
//     //   description: prdct.description,
//     //   imageUrl: prdct.imageUrl,
//     //   price: prdct.price,
//     //   isFavorite: prdct.isFavorite,
//     // );
//     // print('info:${newproduct.id}');
//     // _items.add(newproduct); //insert at last
//     // //or
//     // // _items.insert(0, newproduct); //if we want to insert product at indext =
//     // notifyListeners();
//   }

//with async
  Future<void> addProduct(Product prdct) async {
    //async is always retun future so do not need to write retrun
    // final url = Uri.parse(
    //     'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products'); //this time catcherror will run
    final url = Uri.parse(
        'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products.json'); //products.json - is a node
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': prdct.title,
          'description': prdct.description,
          'imageUrl': prdct.imageUrl,
          'price': prdct.price,
          'imageUrl': prdct.imageUrl,
          'isFavorite': prdct.isFavorite,
        }),
      );
      //after taking response
      final newproduct = Product(
        id: json.decode(response.body)['name'], //
        title: prdct.title,
        description: prdct.description,
        imageUrl: prdct.imageUrl,
        price: prdct.price,
        isFavorite: prdct.isFavorite,
      );
      print('info:${newproduct.id}');
      _items.add(newproduct); //insert at last
      //or
      // _items.insert(0, newproduct); //if we want to insert product at indext =
      notifyListeners();
    } catch (error) {
      //if response throw error then this catch will execute
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newproduct) {
    //  final prctobj=findById(id);
    //  final index=prctobj.
    final productindex = _items.indexWhere((element) {
      return element.id == id;
    });
    if (productindex >= 0) {
      _items[productindex] = newproduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
