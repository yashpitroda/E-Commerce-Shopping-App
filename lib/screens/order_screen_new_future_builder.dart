import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item_widgets.dart';


import '../providers/order.dart';
import '../widgets/app_drawer.dart';

class OrdersScreenNewFutureBuilder extends StatelessWidget {
  static const routeName = '/ordernewscreen';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Order>(context,listen: false).fatchAndsetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling 
              print(dataSnapshot.error);
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Order>(
                builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) => OrderItemWidget(orderData.orders[i]),
                    ),
              );
            }
          }
        },
      ),
    );
  }
}
