import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
    required this.showFav,
    // required this.loadedProductList,
  }) : super(key: key);

  // final List<Product> loadedProductList;
  final bool showFav;
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(
        context); //listen: false -- here we can not asign -- when we add new item in list then it will need to be updated
    final products_item_list =
        showFav ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
        itemCount: products_item_list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
            // create: (c) => products_item_list[i],//product() //object
            value: products_item_list[
                i], //whenever we back to this page then this providerdata automatic delete with the help of value//so do not need to clean up
            child: ProductItem(
                // id: products_item_list[i].id,
                // title: products_item_list[i].title,
                // imageUrl: products_item_list[i].imageUrl),
                ),
          );
        });
  }
}
