import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // FONTS
  static const String fontFamily = 'Manrope';
  static const String fontFamilyHeading = 'Outfit'; // set a different font for headings if desired

  // COLORS
  static const Color bg = Color(0xFFF7F2F2);
  static const Color primary = Color(0xFFF4C2C2); // blush pink
  static const Color primaryDark = Color(0xFFE8A8A8);
  static const Color bannerPurple = Color(0xFFDCD3E5);
  static const Color buttonGreen = Color(0xFFC9E4C5);
  static const Color buttonGreenDark = Color(0xFF8FBF8A);
  static const Color favoriteRed = Color(0xFFE57373);

  // NEUTRALS
  static const Color darkText = Color(0xFF4E3E38);
  static const Color bodyText = Color(0xFF6B5952);
  static const Color grayText = Color(0xFF8A7670);
  static const Color mutedText = Color(0xFFA69890);
  static const Color white = Colors.white;
  static const Color placeholderBg = Color(0xFFF2EEE2);
  static const Color placeholderIcon = Color(0xFFBFBFBF);
  static const Color borderGray = Color(0xFFE0E0E0);
  static const Color dividerGray = Color(0xFFEFEFEF);

  // STATE / FEEDBACK COLORS
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFF44336);
  static const Color starGold = Color(0xFFFFB74D);
  static const Color badgeCoral = Color(0xFFE0948F); // cart/notification badge — sampled from Figma, distinct from primary

  // SHADOWS
  static List<BoxShadow> get cardShadow => [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
      ];

  static List<BoxShadow> get softShadow => [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
      ];

  static List<BoxShadow> get navShadow => [
        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -4)),
      ];

  // SPACING
  static const double radiusSm = 10;
  static const double radiusMd = 15;
  static const double radiusLg = 20;
  static const double radiusPill = 30;
  static const double screenPadding = 20;

  // TEXT STYLES
  static const TextStyle heading = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: darkText,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: darkText,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: darkText,
  );

  static const TextStyle price = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: darkText,
  );

  static const TextStyle priceLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: darkText,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: bodyText,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    color: grayText,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: grayText,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: darkText,
  );

  static const TextStyle buttonOnDark = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: white,
  );

  // FULL APP THEME
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: bg,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSeed(seedColor: primary, background: bg),
      useMaterial3: true,
      fontFamily: fontFamily,
      dividerColor: dividerGray,

      textTheme: const TextTheme(
        headlineSmall: heading,
        titleLarge: heading2,
        titleMedium: cardTitle,
        bodyMedium: body,
        bodySmall: caption,
        labelLarge: button,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: darkText,
        centerTitle: false,
        iconTheme: IconThemeData(color: darkText),
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamilyHeading,
        ),
      ),

      // Labels always float on top (matches Figma form design).
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(color: grayText, fontSize: 13, fontWeight: FontWeight.w600),
        floatingLabelStyle: const TextStyle(color: darkText, fontSize: 13, fontWeight: FontWeight.w600),
        hintStyle: TextStyle(color: mutedText, fontSize: 14, fontFamily: fontFamily),
        errorStyle: const TextStyle(color: errorRed, fontSize: 12, fontFamily: fontFamily),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: borderGray, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: borderGray, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: successGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: errorRed, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPill),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}