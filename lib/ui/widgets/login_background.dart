import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marvel_comics/providers/providers.dart';
import 'package:marvel_comics/theme/app_theme.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {    
    final loginFormProvider = Provider.of<LoginProvider>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _MarvelComicsGif(),
          _MarvelComicsPicture(),
          this.child,
          loginFormProvider.isLoading
            ? Opacity(
                opacity: 0.7,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              )
            : Container(),
        ],
      ),
    );
  }
}

class _MarvelComicsGif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      // margin: EdgeInsets.only(top: screenSize.height * 0.1),
      width: double.infinity,
      height: screenSize.height * 0.50,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/marvel-comics.gif'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
          decoration: BoxDecoration(color: AppTheme.marvelGrey.withOpacity(0.8))
        ),
      ),
    );
  }
}

class _MarvelComicsPicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.2),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            AppTheme.marvelGreyDark,
            AppTheme.marvelGrey,
            Colors.transparent
          ],
          stops: [
            0.05,
            0.35,
            0.7,
            1
          ],
          begin: Alignment(-1.0, 1),
          end: Alignment(-1.0, -1),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
          decoration: BoxDecoration(color: AppTheme.marvelGrey.withOpacity(0))
        ),
      ),
    );
  }
}
