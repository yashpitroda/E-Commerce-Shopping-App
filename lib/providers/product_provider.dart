// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  String authToken;
  ProductProvider(this.authToken, this._items);
  //ChangeNotifier is a widget which astablis comueniication b/w penal with the help of contex
  List<Product> _items = [
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   isFavorite: false,
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   isFavorite: false,
    // ),
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
        'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products.json?auth=$authToken '); //products.json - is a node
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
        id: json.decode(response.body)['name'], //firebasekey
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

  Future<void> fatchAndsetProducts() async {
    final url = Uri.parse(
        // 'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products.json');
    'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    // try {
    final response = await http.get(url);
    print(response);
    print(response.body);
    if (response.body == 'null') {
      //response.body has no value but as a string 'null'
      //mean firebse is empty
      print('its products retruns data is not avalible in firebase server');
      return;
    }
    print(jsonDecode(response.body));
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    //   if (extractedData == null) {
    //   return;
    // }
    print('it hapan');
    print(response.statusCode);
    print(response.persistentConnection);
    print(response.isRedirect);
    final List<Product> loadedProducts = []; // temp list
    extractedData.forEach((firebaseProKey, prodata) {
      print(firebaseProKey);
      loadedProducts.add(
        Product(
            title: prodata['title'],
            id: firebaseProKey,
            description: prodata['description'],
            // price: double.parse(prodata['price'].toString()) ,
            price: prodata['price'].toDouble(),
            imageUrl: prodata['imageUrl'],
            isFavorite: prodata['isFavorite']),
      );
      print(prodata['price'].runtimeType);

      print('do');
    });
    print('it 2 hapan');
    _items = loadedProducts;
    notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw error;
    // }
  }
//whcen firebasekey is null at that time addproduct
//whcen firebasekey is not null at that time mean item is already exsist at that time updateProduct

  Future<void> updateProduct(String id, Product newproduct) async {
    //  final prctobj=findById(id);
    //  final index=prctobj.
    print('in updateProduct of provider : ${id}');
    final productindex = _items.indexWhere((element) {
      return element.id == id;
    });
    print('pindex:${productindex}');
    if (productindex >= 0) {
      final url = Uri.parse(
          'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      //patch -- update data
      await http.patch(url,
          body: json.encode({
            'title': newproduct.title,
            'description': newproduct.description,
            'imageUrl': newproduct.imageUrl,
            'price': newproduct.price,
          }));
      _items[productindex] = newproduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
//without future --its work proper
// void deleteProduct(String id)  {
//     //without firebase
//     // _items.removeWhere((prod) => prod.id == id);
//     // notifyListeners();
//     //withfirebase -- batter way
//     //statuscode: 200,201 - means every things works
//     //statuscode:300 - means u are redairected
//     //statuscode: and above 400 - mean error accor
//     //in http package -  all get and post request automaticaly throws error  wchen status code is graterthen equals to 400
//     //means get and post request are throws error is base on statuscode
//     //but in delete this facality is not avalible -- so we manualy catch error for delete on the bases of statuscode
//     //in delete : statuscode >=400 : means error occurs
//     final url = Uri.parse(
//         // 'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products/$id.json');
//         'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products/$id');
//     final existingProductIndex =
//         _items.indexWhere((element) => element.id == id);
//     dynamic existingProduct =
//         _items[existingProductIndex]; //we can asign null also

//     http.delete(url).then((response) {
//       print(response.statusCode);
//       if (response.statusCode >= 400) {
//         throw HttpException('Could not delete prduct.');
//       }
//       existingProduct = null;
//       print(existingProduct);
//     }).catchError((_) {
//       _items.insert(existingProductIndex, existingProduct);
//       notifyListeners();
//     });
//     _items.removeAt(existingProductIndex);
//     notifyListeners();
//   }

  Future<void> deleteProduct(String id) async {
    //without firebase
    // _items.removeWhere((prod) => prod.id == id);
    // notifyListeners();
    //withfirebase -- batter way
    //statuscode: 200,201 - means every things works
    //statuscode:300 - means u are redairected
    //statuscode: and above 400 - mean error accor
    //in http package -  all get and post request automaticaly throws error  wchen status code is graterthen equals to 400
    //means get and post request are throws error is base on statuscode
    //but in delete this facality is not avalible -- so we manualy catch error for delete on the bases of statuscode
    //in delete : statuscode >=400 : means error occurs
    final url = Uri.parse(
        'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    // 'https://shop-app-f1d6e-default-rtdb.firebaseio.com/products/$id'); //statusconde above 400
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    dynamic existingProduct =
        _items[existingProductIndex]; //we can asign null also
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);

    print(response.statusCode);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete prduct.');
    }
    existingProduct = null;
    print(existingProduct);
  }
}
