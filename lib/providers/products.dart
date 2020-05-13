import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/providers/product.dart';

class Products with ChangeNotifier{
//  bool _showFavoriteOnly = false;

  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product product){
    _items.add(product);
    notifyListeners();
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