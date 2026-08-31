// PART: CART MODEL
import 'product.dart';

class CartModel {
  final List<CartItem> items = [];

  // Sums up the total quantity of all items in the cart.
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  // Sums up the total cost of all items in the cart.
  double get subtotal => items.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  // Adds a new item to the cart. If the exact same item and size already exists, it just increases its quantity.
  void add(CartItem item) {
    for (var existing in items) {
      if (existing.product.name == item.product.name && existing.size == item.size) {
        existing.quantity += item.quantity;
        return;
      }
    }
    items.add(item);
  }

  // Removes an item from the cart completely.
  void remove(CartItem item) => items.remove(item);

  // Updates the quantity of a specific item. If it drops to zero, the item is removed from the cart.
  void updateQty(CartItem item, int delta) {
    final index = items.indexOf(item);
    if (index != -1) {
      items[index].quantity += delta;
      if (items[index].quantity <= 0) {
        items.removeAt(index);
      }
    }
  }

  // Empties the entire cart.
  void clear() => items.clear();
}