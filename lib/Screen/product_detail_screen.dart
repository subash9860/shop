import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routenName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
