import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';

class ComicsTabScreen extends StatefulWidget {
  static const String routerName = 'ComicsTab';

  @override
  State<ComicsTabScreen> createState() => _ComicsTabScreenState();
}

class _ComicsTabScreenState extends State<ComicsTabScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final comicsService = Provider.of<ComicsService>(context);
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 550;

    return SafeArea(
      child: Stack(
        children: [
          ComicsBackground(),
          useMobileLayout
            //! Descomentar y comentar el siguiente "?" para cambiar la forma de ver los comics a Swiper
            //! (El Swiper aún no tiene implementado el infinite scroll)
            // ? ComicsMobile(
            //     screenName: ComicsTabScreen.routerName, 
            //     comics: comicsService.comics,
            //     onNextPage: () {
            //       if (!comicsService.isBusy) {
            //         comicsService.getComics();
            //       }
            //     },
            //   )
            ? ComicsMobileColumns(
                screenName: ComicsTabScreen.routerName, 
                comics: comicsService.comics,
                onNextPage: () {
                  if (!comicsService.isBusy) {
                    comicsService.getComics();
                  }
                },
              )
            : ComicsTablet(
                screenName: ComicsTabScreen.routerName, 
                comics: comicsService.comics,
                onNextPage: () {
                  if (!comicsService.isBusy) {
                    comicsService.getComics();
                  }
                },
              ),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}