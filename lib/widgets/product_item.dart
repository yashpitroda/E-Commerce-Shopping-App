import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/product_details_screen.dart';

import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem(
  //     {Key? key, required this.id, required this.title, required this.imageUrl})
  //     : super(key: key);
  // final String id, title, imageUrl;

  // @override
  // Widget build(BuildContext context) {
  //   //ex of nested provider

  //   // using provider.of
  //   final product_at_index = Provider.of<Product>(
  //       context); //product_at_index is item[i] -- product object//it is only one element of items list //in items list each elemet is object of class product
  //   //we can use consumer instad of provider.of(context)
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.of(context).push(MaterialPageRoute(
  //         //     builder: (ctx) => ProductDetailsScreen(
  //         //           title: title,
  //         //         )));
  //         //if we want to
  //         //pushNamed is best way
  //         Navigator.of(context).pushNamed(
  //           ProductDetailsScreen.routeName,
  //           arguments: product_at_index.id,
  //         );
  //       },
  //       child: GridTile(
  //         child: Image.network(
  //           product_at_index.imageUrl,
  //           fit: BoxFit.cover,
  //         ),
  //         footer: GridTileBar(
  //           backgroundColor: Colors.black54,
  //           leading: IconButton(
  //             icon: Icon(product_at_index.isFavorite
  //                 ? Icons.favorite
  //                 : Icons.favorite_border),
  //             color: Theme.of(context).accentColor,
  //             onPressed: () {
  //               product_at_index.toggleFavoriteStatus();
  //             },
  //           ),
  //           title: Text(
  //             product_at_index.title,
  //             textAlign: TextAlign.center,
  //           ),
  //           trailing: IconButton(
  //             icon: Icon(Icons.shopping_cart),
  //             onPressed: () {},
  //             color: Theme.of(context).accentColor,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

//or using consumer method

  //   //we can use consumer instad of provider.of(context)
  // final cart = Provider.of<Cart>(context,listen: false);//widget is not re build when item is changing
  //  //if we want to apply cart property -- consumer take only one class --soln is in bellow
  //   return Consumer<Product>(
  //     //in consumer type cast to object
  //     builder: (context, value, child) => ClipRRect(
  //       //value mean object:product
  //       //so we pass value to acess the data(for id,title,iamgeUrl)
  //       borderRadius: BorderRadius.circular(10),
  //       child: GestureDetector(
  //         onTap: () {
  //           // Navigator.of(context).push(MaterialPageRoute(
  //           //     builder: (ctx) => ProductDetailsScreen(
  //           //           title: title,
  //           //         )));
  //           //if we want to
  //           //pushNamed is best way
  //           Navigator.of(context).pushNamed(
  //             ProductDetailsScreen.routeName,
  //             arguments: value.id,
  //           );
  //         },
  //         child: GridTile(
  //           child: Image.network(
  //             value.imageUrl,
  //             fit: BoxFit.cover,
  //           ),
  //           footer: GridTileBar(
  //             backgroundColor: Colors.black54,
  //             leading: IconButton(
  //               icon: Icon(
  //                   value.isFavorite ? Icons.favorite : Icons.favorite_border),
  //               color: Theme.of(context).accentColor,
  //               onPressed: () {
  //                 value.toggleFavoriteStatus();
  //               },
  //             ),
  //             title: Text(
  //               value.title,
  //               textAlign: TextAlign.center,
  //             ),
  //             trailing: IconButton(
  //               icon: Icon(Icons.shopping_cart),
  //               onPressed: () {},
  //               color: Theme.of(context).accentColor,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

  //or
  @override
  Widget build(BuildContext context) {
    //ex of nested provider

    // using provider.of
    final product_at_index = Provider.of<Product>(context,
        listen:
            false); //product_at_index is item[i] -- product object//it is only one element of items list //in items list each elemet is object of class product
    final cart = Provider.of<Cart>(context, listen: false);
    //we can use consumer instad of provider.of(context)
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (ctx) => ProductDetailsScreen(
          //           title: title,
          //         )));
          //if we want to
          //pushNamed is best way
          Navigator.of(context).pushNamed(
            ProductDetailsScreen.routeName,
            arguments: product_at_index.id,
          );
        },
        child: GridTile(
          child: Image.network(
            product_at_index.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(product_at_index.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  product_at_index.toggleFavoriteStatus();
                },
              ),
            ),
            title: Text(
              product_at_index.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product_at_index.id!, product_at_index.price,
                    product_at_index.title);
                // Scaffold.of(context).openDrawer();
                // Scaffold.of(context)
                //     .hideCurrentSnackBar(); //if another sanckbar is coming then old sanckbar will hide and
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(
                //       '${product_at_index.title} is Added ittem to cart!',
                //       // textAlign: TextAlign.center,
                //     ),
                //     duration: Duration(seconds: 2),
                //     action: SnackBarAction(
                //       label: "UNDO",
                //       onPressed: () {
                //         cart.removeRecentlyAddedSingleItem(product_at_index.id);
                //       },
                //     ),
                //   ),
                // );
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
