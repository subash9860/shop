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
    // final ordersData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Yours Orders"),
        ),
        drawer: const Drawerscreen(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (data.error != null) {
                  //...
                  // do error handling stuff
                  return const Center(
                    child: Text("erroe occures"),
                  );
                } else {
                  return Consumer<Orders>(
                      builder: (ctx, ordersData,child) => ListView.builder(
                          itemCount: ordersData.orders.length,
                          itemBuilder: (ctx, i) =>
                              OrdersItems(ordersData.orders[i]))) ;
                }
              }
            }));
  }
}
