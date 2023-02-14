import 'package:flutter/material.dart';
import 'package:marvel_comics/theme/app_theme.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,}) 
    
  {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.primary),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.primary,
          width: 2,
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: AppTheme.primary)
        : null
    );
  }
}
