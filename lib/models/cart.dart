import 'package:flutter/foundation.dart';

class Cart {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  Cart({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}