import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/order.dart';
import '../providers/product_provider.dart';
import '../widgets/order_item_widgets.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  Future<void> _refreshOrders(BuildContext context) async {
    await Provider.of<Order>(context, listen: false).fatchAndsetOrders();
  }

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isloading = false;
  @override
  void initState() {
    setState(() {
      _isloading = true;
    });
    //alternative way //or we use this in didchangedipedancy
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<Order>(context, listen: false).fatchAndsetOrders();
      setState(() {
        _isloading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => widget._refreshOrders(context),
        child: (_isloading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) => OrderItemWidget(orderData.orders[i]),
              ),
      ),
    );
  }
}
