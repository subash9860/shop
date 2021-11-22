import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screen/auth_screen.dart';
import 'package:shop/providers/auth.dart';

import '../Screen/users_products_screen.dart';
import '../Screen/order_screen.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text("Orders"),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrderScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Manage Your Products"),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, UserProductScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log Out"),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout(context);
              // Navigator.pushReplacementNamed(context, AuthScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
