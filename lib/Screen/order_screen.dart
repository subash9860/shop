import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screen/drawer_screen.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widget/orders_items.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yours Orders"),
      ),
      drawer:const Drawerscreen(),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (ctx, i) => OrdersItems(ordersData.orders[i])),
    );
  }
}
