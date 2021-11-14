import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screen/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  const UserProductItem(this.id, this.imageUrl, this.title, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.purple,
                  )),
              IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
