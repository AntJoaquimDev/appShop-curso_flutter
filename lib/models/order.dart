import 'package:shop/models/cart_items.dart';

class Order {
  final String id;
  final DateTime date;
  final double total;

  final List<CartItem> products;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.products,
  });
}
