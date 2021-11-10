import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _textController = TextEditingController();
  final _imageURLFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  var _init = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId.isEmpty) {
        _editProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          // 'imageUrl': _editProduct.imageUrl,
          'imageUrl': ''
        };
        _textController.text = _editProduct.imageUrl;
      }
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageURLFocusNode.removeListener(_updateImageURL);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _textController.dispose();
    _imageURLFocusNode.dispose();
    super.dispose();
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      if (_textController.text.isEmpty ||
          !_textController.text.startsWith('http') &&
              !_textController.text.startsWith('https') ||
          !_textController.text.endsWith('.png') &&
              !_textController.text.endsWith('.jpg') &&
              !_textController.text.endsWith('jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final validData = _form.currentState!.validate();
    if (!validData) {
      return;
    }
    _form.currentState!.save();
    if (_editProduct.id.isEmpty) {
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: const InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter title";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        title: value!,
                        description: _editProduct.description,
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl,
                        isFavorite: _editProduct.isFavorite);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Price";
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter price in number.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter a number greater than Zero.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        title: _editProduct.title,
                        description: _editProduct.description,
                        price: double.parse(value!),
                        imageUrl: _editProduct.imageUrl,
                        isFavorite: _editProduct.isFavorite);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['descriptions'],
                  decoration: const InputDecoration(labelText: "Descriptions"),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Descriptions.";
                    }
                    if (value.length < 10) {
                      return "should be at least 10 characters long.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        title: _editProduct.title,
                        description: value!,
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl,
                        isFavorite: _editProduct.isFavorite);
                  },
                ),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.3,
                          margin: const EdgeInsets.only(top: 15, right: 8),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _textController.text.isEmpty
                              ? const Text("Enter a URL")
                              : FittedBox(
                                  child: Image.network(
                                    _textController.text,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          initialValue: _initValues['imageUrl'],
                          decoration:
                              const InputDecoration(labelText: "Image URL"),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _textController,
                          focusNode: _imageURLFocusNode,
                          onFieldSubmitted: (_) => _saveForm(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter image url";
                            }
                            if (!value.startsWith('http') &&
                                value.startsWith('https')) {
                              return 'Please Entern a valid URL';
                            }
                            if (!value.endsWith('.png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('jpeg')) {
                              return "Please Enter valid url.";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editProduct = Product(
                                id: _editProduct.id,
                                title: _editProduct.title,
                                description: _editProduct.description,
                                price: _editProduct.price,
                                imageUrl: value!,
                                isFavorite: _editProduct.isFavorite);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
