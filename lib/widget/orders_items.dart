import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/providers/orders.dart';

class OrdersItems extends StatefulWidget {
  final OrderItem orders;
  const OrdersItems(this.orders, {Key? key}) : super(key: key);

  @override
  State<OrdersItems> createState() => _OrdersItemsState();
}

class _OrdersItemsState extends State<OrdersItems> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(9),
      child: Column(
        children: [
          ListTile(
            title: Text("Total price: \$ ${widget.orders.amount}"),
            subtitle: Text(DateFormat('dd/MM/yyyy    hh:mm')
                .format(widget.orders.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.orders.products.length * 20.0 + 10, 180),
              child: ListView(
                children: widget.orders.products
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${e.quantity} x \$${e.price}",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
