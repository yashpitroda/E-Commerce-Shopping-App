import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   //it allow to register the class which listen in class wigits ,whenever the class update all listener are upadeted
    //   //on main we not use value//so we use create //bcz basicaly hole app will build
    //   create: (context) =>
    //       ProductProvider(), //whenever we change something in class and then we call nofier lisner then all the widget which are listening are re build //not the hole matrial app  //it only rebiuld the widgets wchich are listing
    //   // or
    //   // return ChangeNotifierProvider.value(//.value -- another method of above //short cut of create
    //   //  value: ProductProvider(),
    //   child: MaterialApp(
    //       title: 'Flutter Demo',
    //       theme: ThemeData(
    //         primarySwatch: Colors.purple,
    //         accentColor: Colors.deepOrange,
    //         fontFamily: 'Lato',
    //       ),
    //       home: const ProductOverviewScreen(),
    //       routes: {
    //         ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
    //       }),
    // );
//now we want add cartitem as provider tjen we need multiprovider as ChangeNotifierProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Order(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          // home: const ProductOverviewScreen(),
          routes: {
            '/': (ctx) => ProductOverviewScreen(),
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          }),
    );
  }
}
