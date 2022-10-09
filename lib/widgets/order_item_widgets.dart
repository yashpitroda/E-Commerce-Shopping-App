import 'dart:math';

import 'package:flutter/material.dart';

import '../providers/order.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem order;

  OrderItemWidget(this.order);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              (_expanded)
                  ? 'Total Amount:  \$${widget.order.amount}'
                  : '\$${widget.order.amount}',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              // DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
              widget.order.dateTime.toIso8601String(),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
  if (_expanded)
  Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Items',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              'Amount',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              'quantity',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Divider(),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        height: min(widget.order.products.length * 20 + 8, 80),
        child: ListView(
          children: widget.order.products.map((e) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.title,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "\$ ${e.price}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${e.quantity}x",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    ],
  ),
  ],
  ),
  );
  }
  // ------- or

  // Widget build(BuildContext context) {
  //   return AnimatedContainer(
  //     duration: Duration(milliseconds: 300),
  //     height:
  //         _expanded ? min(widget.order.products.length * 20.0 + 110, 200) : 95,
  //     child: Card(
  //       margin: EdgeInsets.all(10),
  //       child: Column(
  //         children: <Widget>[
  //           ListTile(
  //             title: Text('\$${widget.order.amount}'),
  //             subtitle: Text(
  //               // DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
  //               widget.order.dateTime.toIso8601String(),
  //             ),
  //             trailing: IconButton(
  //               icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
  //               onPressed: () {
  //                 setState(() {
  //                   _expanded = !_expanded;
  //                 });
  //               },
  //             ),
  //           ),
  //           AnimatedContainer(
  //             duration: Duration(milliseconds: 300),
  //             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
  //             height: _expanded
  //                 ? min(widget.order.products.length * 20.0 + 10, 100)
  //                 : 0,
  //             child: ListView(
  //               children: widget.order.products
  //                   .map(
  //                     (prod) => Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: <Widget>[
  //                         Text(
  //                           prod.title,
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         Text(
  //                           '${prod.quantity}x \$${prod.price}',
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             color: Colors.grey,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   )
  //                   .toList(),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
