import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screen/edit_product_screen.dart';
import '../widget/user_products_items.dart';
import '../providers/products.dart';
import '../Screen/drawer_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';
  const UserProductScreen({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchandSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your products"), actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, EditProductScreen.routeName,
                arguments: '');
          },
        ),
      ]),
      drawer: const Drawerscreen(),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) => UserProductItem(
            productData.items[i].id,
            productData.items[i].imageUrl,
            productData.items[i].title,
          ),
        ),
      ),
    );
  }
}
