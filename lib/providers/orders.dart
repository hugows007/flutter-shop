import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart.dart';
import 'package:shop/providers/cart_items.dart';
import 'package:shop/utils/constants.dart';

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
  final String _baseUrl = '${Constants.BASE_API_URL}/orders';

  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(CartItems cart) async {
    //final total = products.fold(0.0, (t, i) => t + (i.price * i.quantity));
    final date = DateTime.now();
    final response = await http.post(
      "$_baseUrl.json",
      body: json.encode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values
            .map((item) => {
                  'id': item.id,
                  'productId': item.productId,
                  'title': item.title,
                  'quantity': item.quantity,
                  'price': item.price,
                })
            .toList(),
      }),
    );

    _items.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          total: cart.totalAmount,
          date: date,
          products: cart.items.values.toList(),
        ));

    notifyListeners();
  }

  Future<void> loadOrders() async {
    final response = await http.get("$_baseUrl.json");
    Map<String, dynamic> data = json.decode(response.body);
    List<Order> loadedItems = [];

    _items.clear();
    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(
          Order(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>).map(
              (item) {
                return Cart(
                  id: item['id'],
                  price: item['price'],
                  productId: item['productId'],
                  quantity: item['quantity'],
                  title: item['title'],
                );
              },
            ).toList(),
          ),
        );
      });
      notifyListeners();
    }

    _items = loadedItems.reversed.toList();

    return Future.value();
  }
}
