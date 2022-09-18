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
  var _isexpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              (_isexpanded)
                  ? 'Total Amount:  \$${widget.order.amount}'
                  : '\$${widget.order.amount}',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              // DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
              widget.order.dateTime.toIso8601String(),
            ),
            trailing: IconButton(
              icon: Icon(_isexpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isexpanded = !_isexpanded;
                });
              },
            ),
          ),
          if (_isexpanded)
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
}
