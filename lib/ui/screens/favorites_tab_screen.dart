import 'package:flutter/material.dart';

class FavoritesTabScreen extends StatelessWidget {
  static const String routerName = 'FavoritesTab';
  
  const FavoritesTabScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
         child: Text('FavoritesTabScreen'),
      ),
    );
  }
}