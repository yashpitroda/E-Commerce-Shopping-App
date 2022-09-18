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
                Orderbutton(cart: cart),
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

class Orderbutton extends StatefulWidget {
  const Orderbutton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<Orderbutton> createState() => _OrderbuttonState();
}

class _OrderbuttonState extends State<Orderbutton> {
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (widget.cart.totalAmount <= 0 || _isloading)
            ? null //btn desable
            : () async {
                setState(() {
                  _isloading = true;
                });
                //in method we dont want call lisner //we need to only run method
                await Provider.of<Order>(context, listen: false).addOrder(
                    widget.cart.cartItemMap.values.toList(),
                    widget.cart.totalAmount);
                setState(() {
                  _isloading = false;
                });
                widget.cart.clear();
              },
        child: _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text('Order Now'));
  }
}
