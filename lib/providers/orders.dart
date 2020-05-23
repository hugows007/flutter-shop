import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/providers/cart_items.dart';

class Order {
  final String id;
  final double total;
  final List<Cart> products;
  final DateTime date;

  Order({
    @required this.id,
    @required this.total,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount{
    return _items.length;
  }

  void addOrder(CartItems cart) {
    //final total = products.fold(0.0, (t, i) => t + (i.price * i.quantity));
    _items.insert(0, Order(
      id: Random().nextDouble().toString(),
      total: cart.totalAmount,
      date: DateTime.now(),
      products: cart.items.values.toList(),
    ));

    notifyListeners();
  }
}
