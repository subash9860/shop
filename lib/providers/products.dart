import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/model/http_exception.dart';
import 'dart:convert';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       // 'assets/burger.jpg'
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       // 'assets/coffee.jpg'
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       //  'assets/dessert.jpg'
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       // 'assets/pizza.jpg'
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
    // _items.firstWhereOrNull((index, element) => e)((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  Future<void> fetchandSetProducts() async {
    var url = Uri.parse(
        'https://shop-20ff4-default-rtdb.asia-southeast1.firebasedatabase.app/product.json');
    try {
      final respond = await http.get(url);
      // print(json.decode(respond.body));

      final extractedData = json.decode(respond.body) as Map<String, dynamic>;
      // extractedData.forEach((key, value) {
      //   print(key);
      //   print(value['title']);
      //   print(value['description']);
      //   print(value['price']);
      //   print(value['imageUrl']);
      //   print(value['isFavorite']);
      // });
      if (extractedData.isEmpty) {
      return;
    }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, proData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: proData['title'],
            description: proData['description'],
            price: proData['price'],
            imageUrl: proData['imageUrl'],
            isFavorite: proData['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        'https://shop-20ff4-default-rtdb.asia-southeast1.firebasedatabase.app/product.json');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      // .then((response) {
      // print(json.decode(response.body)['name']);
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      // _items.insert(0, newProduct); // for start of the list
      notifyListeners();
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final proIndex = _items.indexWhere((element) => element.id == id);
    if (proIndex >= 0 && !proIndex.isNaN) {
      var url = Uri.parse(
          'https://shop-20ff4-default-rtdb.asia-southeast1.firebasedatabase.app/product/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[proIndex] = newProduct;
    }

    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    var url = Uri.parse(
        'https://shop-20ff4-default-rtdb.asia-southeast1.firebasedatabase.app/product/$id.json');
    final execitingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProdcut = _items[execitingProductIndex];
    _items.removeAt(execitingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(execitingProductIndex, existingProdcut);
      notifyListeners();
      throw HttpExpection("Could not delete roduct.");
    }
    _items.removeWhere((element) => element.id == id);
  }
}
