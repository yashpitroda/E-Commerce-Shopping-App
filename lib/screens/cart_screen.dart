import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

import '../providers/order.dart';
import '../widgets/cart_item_widgets.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: [
          Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      //in method we dont want call lisner //we need to only run method
                      Provider.of<Order>(context, listen: false).addOrder(
                          cart.cartItemMap.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    child: Text('Order Now')),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.cartItemMap.length,
                itemBuilder: (ctx, i) {
                  return CartItemWidget(
                    id: cart.cartItemMap.values
                        .toList()[i]
                        .id, //convert map to list
                    productId: cart.cartItemMap.keys.toList()[i], //map key
                    price: cart.cartItemMap.values.toList()[i].price,
                    quantity: cart.cartItemMap.values.toList()[i].quantity,
                    title: cart.cartItemMap.values.toList()[i].title,
                  );
                  // return CartItemWidget(id, productId, price, quantity, title)
                }),
          ),
        ],
      ),
    );
  }
}
