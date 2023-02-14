import 'package:flutter/material.dart';

import 'package:marvel_comics/theme/app_theme.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
      child: Container(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        width: double.infinity,
        decoration: _cardShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _cardShape() => BoxDecoration(
          color: AppTheme.marvelGrey,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}
