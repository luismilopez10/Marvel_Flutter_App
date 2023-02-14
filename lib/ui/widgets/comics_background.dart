import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

import 'package:marvel_comics/providers/providers.dart';
import 'package:marvel_comics/theme/app_theme.dart';

class ComicsBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {    
    final currentTheme = Provider.of<ThemeProvider>(context).currentTheme;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/marvel_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
          decoration: currentTheme == AppTheme.darkTheme
            ? BoxDecoration(color: AppTheme.marvelGrey.withOpacity(0.95))
            : BoxDecoration(color: AppTheme.marvelWhite.withOpacity(0.7))
        ),
      ),
    );
  }
}