import 'product.dart';

class CartModel {
  final List<CartItem> items = [];

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => items.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  void add(CartItem item) {
    for (var existing in items) {
      if (existing.product.name == item.product.name && existing.size == item.size) {
        existing.quantity += item.quantity;
        return;
      }
    }
    items.add(item);
  }

  void remove(CartItem item) => items.remove(item);

  void updateQty(CartItem item, int delta) {
    final index = items.indexOf(item);
    if (index != -1) {
      items[index].quantity += delta;
      if (items[index].quantity <= 0) {
        items.removeAt(index);
      }
    }
  }

  void clear() => items.clear();
}