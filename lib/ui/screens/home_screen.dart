import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marvel_comics/providers/providers.dart';
import 'package:marvel_comics/theme/app_theme.dart';
import 'package:marvel_comics/ui/screens/screens.dart';
import 'package:marvel_comics/share_preferences/preferences.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = 'Home';
  
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('MARVEL', style: TextStyle(fontFamily: 'Marvel', fontSize: 50, color: AppTheme.marvelWhite),),
            leading: IconButton(
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
            actions: [
              IconButton(
                onPressed: () {
                  //TODO: Logout
                  print('Logout');
                  return null;
                },
                icon: const Icon(Icons.logout_outlined)
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

    return PageView(
      controller: navigationProvider.pageController,
      physics: const NeverScrollableScrollPhysics(),
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