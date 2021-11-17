import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    var url = Uri.parse(
        'https://shop-20ff4-default-rtdb.asia-southeast1.firebasedatabase.app/product/$id.json');
    try {
      await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
