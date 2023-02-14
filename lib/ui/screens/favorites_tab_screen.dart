import 'package:flutter/material.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:marvel_comics/services/services.dart';

class FavoritesTabScreen extends StatefulWidget {
  static const String routerName = 'FavoritesTab';
  
  @override
  State<FavoritesTabScreen> createState() => _FavoritesTabScreenState();
}

class _FavoritesTabScreenState extends State<FavoritesTabScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final favoriteComics = Provider.of<FavoritesService>(context).favoriteComics;
    
    return Scaffold(
        body: Stack(
        children: [
          ComicsBackground(),
          favoriteComics.isEmpty
          ? const Center(child: Text('Add some Comics to your favorite list first!'))
          : ComicCard(FavoritesTabScreen.routerName, favoriteComics),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}