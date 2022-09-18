import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // const ProductDetailsScreen({Key? key, required this.title}) : super(key: key);
  // final String title;
  static const routeName = '/ProductDetailsScreen';
  
  @override
  Widget build(BuildContext context) {
    
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    // final loadedProduct_List =
    //     Provider.of<ProductProvider>(context).items.firstWhere((element) {
    //   return element.id == productId;
    // });
    //or
    final loadedProduct = Provider.of<ProductProvider>(context, listen: false)
        .findById(
            productId); //listen: false -- if our data will not change or update then we will do false
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
