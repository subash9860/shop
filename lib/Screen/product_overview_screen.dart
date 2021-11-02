import 'package:flutter/material.dart';

import '../model/product.dart';
import '../widget/product_item.dart';

class ProductOverViewScreen extends StatelessWidget {
  ProductOverViewScreen({Key? key}) : super(key: key);

  final List<Product> loadedProduct = [
    Product(
        id: 'p1',
        title: 'Burger',
        description: 'A Humburger - it have great test!',
        price: 29.99,
        imageUrl: 'assets/burger.jpg'
        // 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        ),
    Product(
        id: 'p2',
        title: 'Coffee',
        description: 'A nice coffee with best flaver.',
        price: 59.99,
        imageUrl: 'assets/coffee.jpg'
        // 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        ),
    Product(
        id: 'p3',
        title: 'Desert',
        description: 'Best Desert for  - it fit on all the food.',
        price: 19.99,
        imageUrl: 'assets/dessert.jpg'
        // 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
        ),
    Product(
        id: 'p4',
        title: 'Pizza',
        description: 'Hot pizza in plan.',
        price: 49.99,
        imageUrl: 'assets/pizza.jpg'
        // 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          mainAxisExtent: 180,
        ),
        itemCount: loadedProduct.length,
        itemBuilder: (ctx, i) => ProductItem(loadedProduct[i].id,
            loadedProduct[i].title, loadedProduct[i].imageUrl),
      ),
    );
  }
}
