import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => this._currentPage;

  set currentPage(int value) {
    _currentPage = value;
    _pageController.animateToPage(value, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
