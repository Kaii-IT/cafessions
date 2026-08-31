import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../theme.dart';
import '../models/cart_model.dart';

class OrderInquiryScreen extends StatefulWidget {
  final CartModel cart;

  const OrderInquiryScreen({super.key, required this.cart});

  @override
  State<OrderInquiryScreen> createState() => _OrderInquiryScreenState();
}

class _OrderInquiryScreenState extends State<OrderInquiryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  // FIELD LABEL
  // Text is placed outside the box to match the Figma design.
  Widget _buildFieldLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text.rich(
        TextSpan(
          text: label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkText,
            fontFamily: AppTheme.fontFamily,
          ),
          children: [
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: AppTheme.errorRed),
              ),
          ],
        ),
      ),
    );
  }

  // INPUT DECORATION
  // Changes border color and shows a checkmark when input is valid.
  InputDecoration _baseDecoration({
    String? hintText,
    bool isValid = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: AppTheme.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: 14,
        color: AppTheme.mutedText,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        borderSide: BorderSide(
          color: isValid ? AppTheme.successGreen : AppTheme.borderGray,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        borderSide: const BorderSide(color: AppTheme.successGreen, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        borderSide: const BorderSide(color: AppTheme.errorRed, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        borderSide: const BorderSide(color: AppTheme.errorRed, width: 2.0),
      ),
      suffixIcon: isValid
          ? const Icon(Icons.check_circle, color: AppTheme.successGreen)
          : null,
    );
  }

  // VALIDATION AND SUBMIT
  // Shows a success modal only when all fields are valid. Clears cart on OK.
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Icon(Icons.check_circle, color: Colors.green, size: 50),
            content: const Text(
              'Order Inquiry Submitted!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    widget.cart.clear();
                    Navigator.of(context).pop();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  // APPBAR
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
        title: const Text('Order Inquiry', style: AppTheme.heading),
        actions: [
          // Goes back to the home page regardless of screen stack.
          GestureDetector(
            onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: BoxShape.circle,
                boxShadow: AppTheme.softShadow,
              ),
              child: const Icon(Icons.home, size: 20, color: AppTheme.darkText),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),

      // FORM BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.screenPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Complete Inquiry Details', style: AppTheme.heading2),
              const SizedBox(height: 6),
              Text(
                'Send us your preferences. Our friendly team will contact you via SMS to confirm.',
                style: AppTheme.body.copyWith(color: AppTheme.grayText),
              ),
              const SizedBox(height: 30),

              // FULL NAME
              _buildFieldLabel('Full Name', isRequired: true),
              TextFormField(
                controller: _fullNameController,
                onChanged: (val) => setState(() {}), 
                decoration: _baseDecoration(
                  isValid: _fullNameController.text.isNotEmpty,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required field';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // MOBILE NUMBER
              _buildFieldLabel('Mobile Number', isRequired: true),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                onChanged: (val) => setState(() {}), 
                decoration: _baseDecoration(
                  hintText: '09123456789',
                  isValid: RegExp(r'^[0-9]{10,11}$').hasMatch(_mobileController.text),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required field';
                  if (!RegExp(r'^[0-9]{10,11}$').hasMatch(value)) return 'Please enter a valid mobile number (digits only)';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // EMAIL
              _buildFieldLabel('Email', isRequired: true),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => setState(() {}), 
                decoration: _baseDecoration(
                  hintText: 'example@email.com',
                  isValid: EmailValidator.validate(_emailController.text),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required field';
                  if (!EmailValidator.validate(value)) return 'Please enter a valid email address';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ADDRESS
              _buildFieldLabel('Address', isRequired: true),
              TextFormField(
                controller: _addressController,
                onChanged: (val) => setState(() {}), 
                decoration: _baseDecoration(
                  isValid: _addressController.text.isNotEmpty,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required field';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // SPECIAL NOTES (Optional)
              _buildFieldLabel('Special Notes'),
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                onChanged: (val) => setState(() {}), 
                decoration: _baseDecoration(
                  hintText: 'Allergies, preferences...',
                  isValid: _notesController.text.isNotEmpty,
                ),
              ),
            ],
          ),
        ),
      ),

      // BOTTOM BUTTON
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: AppTheme.darkText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Submit Inquiry', style: AppTheme.button),
                ),
                const SizedBox(height: 12),
                Text(
                  'By submitting, you agree to receive one-time SMS verification.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppTheme.grayText, fontFamily: AppTheme.fontFamily),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}