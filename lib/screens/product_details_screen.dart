import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/cart_model.dart';
import '../models/product.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final CartModel cart;
  final Set<String> favoriteNames; 
  final VoidCallback onToggleFavorites; 

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.cart,
    required this.favoriteNames,
    required this.onToggleFavorites,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedSize = '';
  int _quantity = 1;

  // INITIAL STATE
  // Picks the first size for drinks, or "Regular" for food.
  @override
  void initState() {
    super.initState();
    _selectedSize = widget.product.sizes.isNotEmpty ? widget.product.sizes[0] : 'Regular';
    _quantity = 1; 
  }

  // PRICE LOGIC
  // Adds a peso amount for Medium and Large sizes.
  double get _currentPrice {
    if (widget.product.sizes.isNotEmpty) {
      switch (_selectedSize) {
        case 'Medium': return widget.product.basePrice + 10;
        case 'Large': return widget.product.basePrice + 20;
        default: return widget.product.basePrice;
      }
    }
    return widget.product.basePrice;
  }

  // APPBAR
  @override
  Widget build(BuildContext context) {
    bool isFavorite = widget.favoriteNames.contains(widget.product.name);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: AppTheme.screenPadding),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: const BoxDecoration(
                color: Color(0xFFF2F2F2), 
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppTheme.darkText),
            ),
          ),
        ),
        leadingWidth: 60,
        title: const Text('Menu Details', style: AppTheme.heading),
        actions: [
          // HEART AND CART BUTTONS
          // Heart reads from the shared favorites Set, updates it, and triggers Home to rebuild.
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.favoriteNames.contains(widget.product.name)) {
                  widget.favoriteNames.remove(widget.product.name);
                } else {
                  widget.favoriteNames.add(widget.product.name);
                }
                widget.onToggleFavorites();
              });
            },
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: BoxShape.circle,
                boxShadow: AppTheme.softShadow,
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 20,
                color: isFavorite ? AppTheme.primaryDark : AppTheme.darkText,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cart: widget.cart)));
            },
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: BoxShape.circle,
                boxShadow: AppTheme.softShadow,
              ),
              child: const Icon(Icons.shopping_bag_outlined, size: 20, color: AppTheme.darkText),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PRODUCT IMAGE
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                boxShadow: AppTheme.cardShadow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                child: Image.asset(
                  widget.product.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 25),
            
            // TITLE AND PRICE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.name, style: AppTheme.heading.copyWith(fontSize: 26)),
                Text('\u20b1${_currentPrice.toInt()}', style: AppTheme.priceLarge.copyWith(fontSize: 24)),
              ],
            ),
            const SizedBox(height: 8),

            // RATING
            Row(
              children: [
                for (int i = 0; i < 4; i++) const Icon(Icons.star, color: AppTheme.favoriteRed, size: 18),
                const Icon(Icons.star_half, color: AppTheme.favoriteRed, size: 18),
                const SizedBox(width: 6),
                Text('4.8 (124 reviews)', style: AppTheme.caption),
              ],
            ),
            const SizedBox(height: 20),

            // DESCRIPTION
            Text(
              widget.product.longDesc,
              style: AppTheme.body.copyWith(color: AppTheme.grayText, fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 25),

            // SIZE SELECTION
            // Drinks show three sizes with adjusted prices. Food shows one "Regular" box.
            const Text('Select Size', style: AppTheme.heading2),
            const SizedBox(height: 12),
            if (widget.product.sizes.isNotEmpty)
              Row(
                children: widget.product.sizes.map((size) {
                  bool isSelected = _selectedSize == size;
                  double sizePrice = widget.product.basePrice + (size == 'Medium' ? 10 : (size == 'Large' ? 20 : 0));

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _selectedSize = size;
                        _quantity = 1;
                      }),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primary : AppTheme.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: AppTheme.softShadow,
                          border: isSelected ? null : Border.all(color: AppTheme.borderGray, width: 1),
                        ),
                        child: Column(
                          children: [
                            Text(size, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isSelected ? AppTheme.darkText : AppTheme.grayText, fontFamily: AppTheme.fontFamily)),
                            const SizedBox(height: 2),
                            Text('\u20b1${sizePrice.toInt()}', style: TextStyle(fontSize: 12, color: isSelected ? AppTheme.darkText : AppTheme.grayText, fontFamily: AppTheme.fontFamily)),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppTheme.softShadow,
                  border: Border.all(color: AppTheme.borderGray),
                ),
                child: const Text('Regular', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 30),

            // QUANTITY
            const Text('QUANTITY', style: AppTheme.label),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                boxShadow: AppTheme.softShadow,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_quantity > 1) setState(() => _quantity--);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F4F4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.remove, size: 18, color: AppTheme.darkText),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text('$_quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () => setState(() => _quantity++),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, size: 18, color: AppTheme.darkText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ADD TO CART BUTTON
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -4)),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.darkText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              onPressed: () {
                widget.cart.add(CartItem(
                  product: widget.product,
                  size: _selectedSize,
                  price: _currentPrice,
                  quantity: _quantity,
                ));
                // Shows feedback without leaving the page.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to Cart')),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: AppTheme.darkText, size: 20),
                  const SizedBox(width: 10),
                  Text('Add to Cart - \u20b1${(_currentPrice * _quantity).toInt()}', style: AppTheme.button.copyWith(fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}