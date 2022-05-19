// ignore_for_file: unused_element

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-joaquim-default-rtdb.firebaseio.com/product';
  List<Product> _items = [];
  bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  //retorna o clone dos items da lista
  int get itemCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse('$_baseUrl.json'));
    if (response.body == 'null') {
      return;
    }
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((ProductId, ProductData) {
      _items.add(
        Product(
          id: ProductId,
          name: ProductData['name'] as String,
          description: ProductData['description'] as String,
          price: ProductData['price'] as double,
          imageUrl: ProductData['imageUrl'] as String,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${product.id}.json'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      final prodcut = _items[index];
      _items.remove(product);
      notifyListeners();
//remove primeiro da tela e depois do banco se der erro retorna o produto
      final response = await http.delete(
        Uri.parse('$_baseUrl/${product.id}.json'),
      );
      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
      }
    }
  }
}

/*  bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly) {
      //return [..._items].where((prod) => prod.isFavorite).toList();
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];
  } //retorna o clone dos items da lista

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); //notifica os interessados da mudança de estado
  } */