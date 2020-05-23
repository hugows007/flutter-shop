import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class Products with ChangeNotifier {
//  bool _showFavoriteOnly = false;

  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product product) {
    _items.add(Product(
      id: Random().nextDouble().toString(),
      title: product.title,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product != null && product.id != null) {
      return null;
    }

    final index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((element) => element.id == id);
    if (index >= 0) {
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

// Controlando a exibição globalmente
//  void showFavoriteOnly(){
//    _showFavoriteOnly = true;
//    notifyListeners();
//  }
//
//  void showAll(){
//    _showFavoriteOnly = false;
//    notifyListeners();
//  }
}
