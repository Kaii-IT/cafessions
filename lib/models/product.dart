class Product {
  final String name;
  final String desc;
  final String longDesc;
  final double basePrice;
  final String type;
  final String imagePath; // Updated to String for Image.asset
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