import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  var _isInit = true;
  var _isloading = false;

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fatchAndsetProducts();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<ProductProvider>(context, listen: false)
          .fatchAndsetProducts()
          .then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () =>
            _refreshProducts(context), //it has no argumet but it is future
        child: (_isloading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: productsData.items.length,
                  itemBuilder: (_, i) => Column(
                    children: [
                      UserProductItem(
                        productsData.items[i].id!,
                        productsData.items[i].title,
                        productsData.items[i].imageUrl,
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
