// PART: PRODUCT MODEL
class Product {
  final String name;
  final String desc;
  final String longDesc;
  final double basePrice;
  final String type;
  final String imagePath;
  final List<String> sizes;

  Product({
    required this.name,
    required this.desc,
    required this.longDesc,
    required this.basePrice,
    required this.type,
    required this.imagePath,
    this.sizes = const [],
  });
}

// Holds the specific data for an item once it's inside the cart.
class CartItem {
  final Product product;
  String size;
  double price;
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    required this.price,
    this.quantity = 1,
  });
}