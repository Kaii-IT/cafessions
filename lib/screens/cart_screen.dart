import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/cart_model.dart';
import '../models/product.dart';
import 'order_inquiry_screen.dart';

class CartScreen extends StatefulWidget {
  final CartModel cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text('My Cart', style: AppTheme.heading),
        actions: [
          GestureDetector(
            onLongPress: () {
              setState(() {
                widget.cart.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart cleared')),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: BoxShape.circle,
                boxShadow: AppTheme.softShadow,
              ),
              child: const Icon(Icons.delete_outline, size: 20, color: AppTheme.darkText),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: widget.cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 48, color: AppTheme.grayText),
                  const SizedBox(height: 12),
                  Text("Cart is empty", style: AppTheme.body.copyWith(color: AppTheme.grayText)),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Your Items', style: AppTheme.heading2),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${widget.cart.totalItems}',
                          style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...widget.cart.items.map((item) => _buildCartItem(item)),
                  
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payment Summary', style: AppTheme.heading2),
                        const SizedBox(height: 20),
                        _buildSummaryRow('Subtotal', 'P${widget.cart.subtotal.toInt()}'),
                        const SizedBox(height: 10),
                        _buildSummaryRow('Delivery Fee', 'P45', isGreen: true),
                        const SizedBox(height: 20),
                        Divider(color: AppTheme.dividerGray, thickness: 1),
                        const SizedBox(height: 20),
                        _buildSummaryRow('Total Amount', 'P${(widget.cart.subtotal + 45).toInt()}', isBold: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
      bottomNavigationBar: widget.cart.items.isEmpty
          ? null
          : Container(
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
                      backgroundColor: AppTheme.buttonGreen,
                      foregroundColor: AppTheme.darkText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderInquiryScreen(cart: widget.cart)),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Proceed to Order Inquiry', style: AppTheme.button),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward, color: AppTheme.darkText, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => setState(() => widget.cart.remove(item)),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.placeholderBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.cancel, size: 24, color: AppTheme.grayText),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // UPDATED: Using Image.asset instead of Icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.placeholderBg,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    child: Image.asset(
                      item.product.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.product.name, style: AppTheme.cardTitle),
                      Text('Size: ${item.size}', style: AppTheme.caption),
                      const SizedBox(height: 5),
                      Text('\u20b1${item.price.toInt()}', style: AppTheme.price),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                          border: Border.all(color: AppTheme.borderGray, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => widget.cart.updateQty(item, -1)),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF4F4F4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.remove, size: 16, color: AppTheme.darkText),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text('${item.quantity}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () => setState(() => widget.cart.updateQty(item, 1)),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: AppTheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add, size: 16, color: AppTheme.darkText),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isBold = false, bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, fontFamily: AppTheme.fontFamily, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: isBold ? AppTheme.darkText : AppTheme.grayText)),
        Text(amount, style: TextStyle(fontSize: 14, fontFamily: AppTheme.fontFamily, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: isGreen ? AppTheme.buttonGreenDark : (isBold ? AppTheme.darkText : AppTheme.grayText))),
      ],
    );
  }
}