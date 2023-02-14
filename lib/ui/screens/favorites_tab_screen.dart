import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:marvel_comics/ui/widgets/widgets.dart';
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
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 550;
    
    return Scaffold(
        body: Stack(
        children: [
          ComicsBackground(),
          favoriteComics.isEmpty
          ? const Center(child: Text('Add some Comics to your favorite list first!'))
          : useMobileLayout
            //! Descomentar y comentar el siguiente "?" para cambiar la forma de ver los comics a Swiper
            //! (El Swiper aún no tiene implementado el infinite scroll)
            // ? ComicsMobile(
            //     screenName: FavoritesTabScreen.routerName, 
            //     comics: favoriteComics,
            //     onNextPage: () {},
            //   )
            ? ComicsMobileColumns(
                screenName: FavoritesTabScreen.routerName, 
                comics: favoriteComics,
                onNextPage: () {},
              )
            : ComicsTablet(
                screenName: FavoritesTabScreen.routerName, 
                comics: favoriteComics,
                onNextPage: () {},
              ),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}