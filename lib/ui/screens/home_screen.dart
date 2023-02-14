import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marvel_comics/providers/providers.dart';
import 'package:marvel_comics/theme/app_theme.dart';
import 'package:marvel_comics/ui/screens/screens.dart';
import 'package:marvel_comics/share_preferences/preferences.dart';
import 'package:marvel_comics/services/services.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = 'Home';
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('MARVEL', style: TextStyle(fontFamily: 'Marvel', fontSize: 50, color: AppTheme.marvelWhite),),
            leading: IconButton(
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, LoginScreen.routerName);
              },
              icon: const Icon(Icons.logout_outlined)
            ),
            actions: [
              IconButton(
                icon: Icon(themeProvider.currentTheme == AppTheme.lightTheme
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined),
                onPressed: () {
                  Preferences.isDarkmode = !Preferences.isDarkmode;
                  Preferences.isDarkmode
                    ? themeProvider.setDarkmode()
                    : themeProvider.setLightmode();
                },
              ),
            ],
          ),
          body: _Pages(),
          bottomNavigationBar: _Navigation(),
        ),
      ),
    );
  }
}

class _Pages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 550;

    return PageView(
      controller: navigationProvider.pageController,
      physics: useMobileLayout
        ? const NeverScrollableScrollPhysics()
        : null,
      onPageChanged: (i) => navigationProvider.currentPage = i,
      children: [
        ComicsTabScreen(),
        FavoritesTabScreen(),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return BottomNavigationBar(
      currentIndex: navigationProvider.currentPage,
      onTap: (i) => navigationProvider.currentPage = i,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu_book_sharp), label: 'Comics'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
      ]
    );
  }
}