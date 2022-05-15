import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';

import 'product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  //retorna o clone dos items da lista

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); //notifica os interessados da mudança de estado
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