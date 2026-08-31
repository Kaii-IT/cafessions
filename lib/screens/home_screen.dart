import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product.dart';
import '../theme.dart';
import 'cart_screen.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final Set<String> _favoriteNames = {};
  final CartModel cart = CartModel();

  final List<Product> products = [
    Product(name: 'Classic Americano', desc: 'Bold & smooth daily brew', longDesc: 'Our signature bold and smooth daily brew, made from premium single-origin beans. Slow-dripped to extract a rich, robust flavor profile with a silky finish. Perfect for those who appreciate the pure, unadulterated taste of high-quality coffee.', basePrice: 95, type: 'Drink', imagePath: 'assets/images/classic_americano.webp', sizes: ['Small', 'Medium', 'Large']),
    Product(name: 'Ube Latte', desc: 'Dreamy purple yam latte', longDesc: 'A beautiful, dreamy harmony of creamy native purple yam (ube) and our signature smooth double-shot espresso, finished with velvety steamed milk. Sweet, aromatic, and uniquely comforting—a true Filipino favorite.', basePrice: 145, type: 'Drink', imagePath: 'assets/images/ube_latte.jpg', sizes: ['Small', 'Medium', 'Large']),
    Product(name: 'Spanish Latte', desc: 'Sweet condensed milk blend', longDesc: 'Indulge in our sweet and creamy Spanish Latte, meticulously crafted with condensed milk and a double shot of espresso. Rich, decadent, and perfectly balanced with a bold coffee kick. A sweet escape in every sip.', basePrice: 120, type: 'Drink', imagePath: 'assets/images/spanish_latte.webp', sizes: ['Small', 'Medium', 'Large']),
    Product(name: 'Matcha Frappe', desc: 'Iced ceremonial matcha blend', longDesc: 'Savor the vibrant, earthy notes of our Iced ceremonial matcha blend, hand-whisked to perfection and blended with ice and milk. A refreshing, invigorating drink that balances the subtle bitterness of matcha with a smooth, creamy finish.', basePrice: 130, type: 'Drink', imagePath: 'assets/images/matcha_frappe.webp', sizes: ['Small', 'Medium', 'Large']),
    Product(name: 'Butter Ensaymada', desc: 'Soft buttery Filipino pastry', longDesc: 'Experience the softest, fluffiest Butter Ensaymada you will ever try! Baked fresh daily, this beloved Filipino pastry is generously slathered with premium butter, topped with a delightful layer of grated cheese, and dusted with just the right amount of sugar. A classic treat for any time of day.', basePrice: 85, type: 'Food', imagePath: 'assets/images/ensaymada.webp'),
    Product(name: 'Buko Pandan Slice', desc: 'Coconut pandan layer cake', longDesc: 'A delightful layer of our signature Coconut Pandan cake, infused with the fragrant aroma of fresh pandan leaves and enriched with creamy coconut milk. Light, airy, and perfectly sweet, topped with a velvety cream frosting. A tropical slice of heaven.', basePrice: 120, type: 'Food', imagePath: 'assets/images/bukopandan_slice.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: _selectedIndex == 0 ? _buildHomePage() : _buildFavoritesPage(),
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap, {double size = 20}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: AppTheme.white,
          shape: BoxShape.circle,
          boxShadow: AppTheme.softShadow,
        ),
        child: Icon(icon, size: size, color: AppTheme.darkText),
      ),
    );
  }

  Widget _buildCartIcon() {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cart: cart)));
        setState(() {});
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(color: AppTheme.white, shape: BoxShape.circle, boxShadow: AppTheme.softShadow),
            child: const Icon(Icons.shopping_bag_outlined, size: 20, color: AppTheme.darkText),
          ),
          if (cart.totalItems > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppTheme.badgeCoral, shape: BoxShape.circle),
                child: Text(
                  '${cart.totalItems}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, color: AppTheme.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _toggleFavorite(String productName) {
    setState(() {
      if (_favoriteNames.contains(productName)) {
        _favoriteNames.remove(productName);
      } else {
        _favoriteNames.add(productName);
      }
    });
  }

  Widget _buildLogo({double titleSize = 20}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
          child: const Icon(Icons.local_florist_outlined, color: AppTheme.darkText, size: 20),
        ),
        const SizedBox(width: 10),
        Text('Cafessions', style: AppTheme.heading.copyWith(fontSize: titleSize)),
      ],
    );
  }

  Widget _buildProductCard(Product product, bool isFavorite) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // UPDATED: Using Image.asset instead of Icon
              Container(
                height: 120.0,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.placeholderBg,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  child: Image.asset(
                    product.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => _toggleFavorite(product.name),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.softShadow,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: isFavorite ? AppTheme.favoriteRed : AppTheme.grayText,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: AppTheme.cardTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(product.desc, style: AppTheme.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text('\u20b1${product.basePrice.toInt()}', style: AppTheme.price)),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductDetailsScreen(
                            product: product,
                            cart: cart,
                            favoriteNames: _favoriteNames,
                            onToggleFavorites: () => setState(() {}),
                          )),
                        );
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.darkText, fontFamily: AppTheme.fontFamily)),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right, size: 14, color: AppTheme.darkText),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.screenPadding, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogo(),
                Row(
                  children: [
                    _circleIconButton(Icons.search, () {}),
                    const SizedBox(width: 10),
                    _buildCartIcon(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildBanner(),
            const SizedBox(height: 20),
            _buildCategories(),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double cardWidth = (constraints.maxWidth - 15) / 2;
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 15,
                  runSpacing: 15,
                  children: products.map((product) {
                    bool isFavorite = _favoriteNames.contains(product.name);
                    return SizedBox(
                      width: cardWidth,
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                product: product,
                                cart: cart,
                                favoriteNames: _favoriteNames,
                                onToggleFavorites: () => setState(() {}),
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        onDoubleTap: () => _toggleFavorite(product.name),
                        child: _buildProductCard(product, isFavorite),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppTheme.bannerPurple, borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mabuhay!', style: AppTheme.heading2.copyWith(fontSize: 20)),
          const SizedBox(height: 6),
          Text('Enjoy our specialty blends and local sweet pastries today.', style: AppTheme.body.copyWith(color: AppTheme.grayText)),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(AppTheme.radiusPill)),
            child: const Text('20% off your first order', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.darkText)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildCategoryChip('All', isSelected: true),
        _buildCategoryChip('Coffee'),
        _buildCategoryChip('Pastries'),
        _buildCategoryChip('Meals'),
        _buildCategoryChip('Drinks'),
      ],
    );
  }

  Widget _buildCategoryChip(String title, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primary : AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        border: isSelected ? null : Border.all(color: AppTheme.borderGray),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.darkText, fontFamily: AppTheme.fontFamily),
      ),
    );
  }

  Widget _buildFavoritesPage() {
    List<Product> favorites = products.where((p) => _favoriteNames.contains(p.name)).toList();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.screenPadding, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.favorite, color: AppTheme.white, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text('Favorites', style: AppTheme.heading.copyWith(fontSize: 22)),
                  ],
                ),
                _buildCartIcon(),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.screenPadding),
            child: SizedBox(width: double.infinity, child: _buildCategories()),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: favorites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite_border, size: 40, color: AppTheme.mutedText),
                        const SizedBox(height: 10),
                        Text("No favorites yet", style: AppTheme.body.copyWith(color: AppTheme.grayText)),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.screenPadding),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          double cardWidth = (constraints.maxWidth - 15) / 2;
                          return Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 15,
                            runSpacing: 15,
                            children: favorites.map((product) {
                              return SizedBox(
                                width: cardWidth,
                                child: GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailsScreen(
                                          product: product,
                                          cart: cart,
                                          favoriteNames: _favoriteNames,
                                          onToggleFavorites: () => setState(() {}),
                                        ),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  onDoubleTap: () => _toggleFavorite(product.name),
                                  child: _buildProductCard(product, true),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppTheme.radiusLg),
          topRight: Radius.circular(AppTheme.radiusLg),
        ),
        boxShadow: AppTheme.navShadow,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.menu_book_outlined, 'Menu', 0),
              _buildNavItem(Icons.favorite_border, 'Favorites', 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(AppTheme.radiusPill),
              ),
              child: Icon(icon, color: isSelected ? AppTheme.darkText : AppTheme.grayText, size: 22),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, fontFamily: AppTheme.fontFamily, color: isSelected ? AppTheme.darkText : AppTheme.grayText, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}