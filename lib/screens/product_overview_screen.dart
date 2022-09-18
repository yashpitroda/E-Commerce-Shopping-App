import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/product_item.dart';
// import 'package:shop_app/models/product.dart';
// import 'package:shop_app/widgets/product_item.dart';

import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);
  //

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fatchAndsetProducts();
    print('refresh done');
  }

  // final List<Product> loadedProductList = ;
  var _isShowOnlyfavorites = false;
  var _isInit = true;
  var _isloading = false;
  @override
  void initState() {
    //fatch data form firebase
    //not optimal
    // http.get(); //it is not batter aproch
    //best aproch is fatching code is move to provider class //and hide form widgets and just all method in widgets and fatch the data
    //optimal
    //  Provider.of<ProductProvider>(context).fatchAndsetProducts();//it is future and void so do not store in to response //but context are not use in initstate -- we use didchangedi

    super.initState();
  }

  @override
  void didChangeDependencies() {
    //herre we can write context
    //it si run after widget is fully inislize

    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<ProductProvider>(context).fatchAndsetProducts().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final productsContainer =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop app"),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                print(selectedValue);
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    // productsContainer.showFavoritesOnlyFunction();
                    //or alter native method is turn in to satefull widgets
                    _isShowOnlyfavorites = true;
                  } else {
                    // productsContainer.showAllFunction();
                    _isShowOnlyfavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text(
                        'only Favorites',
                      ),
                      // value: 0,
                      value: FilterOptions.Favorites, //mean 0
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Show All',
                      ),
                      // value: 1,
                      value: FilterOptions.All, //mean 1
                    ),
                  ]),
          Consumer<Cart>(
            builder: (context, cartObj, ch) => Badge(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(Icons.shopping_cart)),
              value: cartObj.itemCount.toString(),
              color: Colors.red,
            ),
            // child://this is not rebuild
            //     IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: (_isloading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: ProductGrid(
                showFav: _isShowOnlyfavorites,
              ),
            ),
    );
  }
}
