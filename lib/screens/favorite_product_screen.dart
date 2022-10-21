import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/drawer/custom_drawer.dart';
import '../widgets/product_grid.dart';

class FavoriteProductScreen extends StatefulWidget {
  static const routeName = '/FavoriteProductScreen';
  const FavoriteProductScreen({super.key});

  @override
  State<FavoriteProductScreen> createState() => _FavoriteProductScreenState();
}

class _FavoriteProductScreenState extends State<FavoriteProductScreen> {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fatchAndsetProducts();
    print('refresh done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite")),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ProductGrid(
          showFav: true,
        ),
      ),
    );
  }
}
