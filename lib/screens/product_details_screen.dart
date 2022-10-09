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
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      // body: SingleChildScrollView(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true, //when we scroling app bar is visible
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id.toString(),
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: //how to rander content of list
                SliverChildListDelegate([
              SizedBox(height: 10),
              Text(
                '\$${loadedProduct.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
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
              ),
              SizedBox(
                height: 810,
              ),
            ]),
          ),
        ],
        // child: Column(
        //   //silver is just scrolble area in screen
        //   children: <Widget>[

        //   ],
        // ),
      ),
    );
  }
}
