import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  const CartItems(
      this.id, this.productId, this.price, this.title, this.quantity,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
        color: Theme.of(context).errorColor,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 29,
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("\$$price",
                        style: const TextStyle(color: Colors.white)))),
            title: Text(title),
            subtitle: Text("total: ${price * quantity}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
