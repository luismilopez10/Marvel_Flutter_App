import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics/providers/providers.dart';
import 'package:marvel_comics/ui/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/theme/app_theme.dart';

class ComicCard extends StatelessWidget {
  final String screenName;
  final List<Comic> comics;

  const ComicCard(this.screenName, this.comics);

  @override
  Widget build(BuildContext context) {
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 550;

    return Container(
      child: useMobileLayout
        // ? _ComicsMobile(screenName, comics)
        ? _ComicsMobileColumns(screenName, comics)
        : _ComicsTablet(screenName, comics),
    );
  }
}

class _ComicsMobile extends StatelessWidget {
  final String screenName;
  final List<Comic> comics;

  const _ComicsMobile(this.screenName, this.comics);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const comicScale = 0.9;

    return Swiper(
      itemCount: comics.length,
      viewportFraction: 1.0,
      layout: SwiperLayout.STACK,
      itemWidth: screenSize.width * 0.73 * comicScale,
      itemHeight: screenSize.height * 0.70 * comicScale,
      itemBuilder: (context, index) {
        return _ImageCard(screenName, comics[index]);
      },
    );
  }
}

class _ComicsMobileColumns extends StatelessWidget {
  final String screenName;
  final List<Comic> comics;

  const _ComicsMobileColumns(this.screenName, this.comics);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 30),
      childAspectRatio: screenSize.height * 0.00085, // 0.64
      mainAxisSpacing: screenSize.height * 0.04,
      crossAxisCount: 2,
      physics: const BouncingScrollPhysics(),
      children: List.generate(comics.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          color: AppTheme.marvelRed,
          child: _ImageCard(screenName, comics[index]),
        );
      }),
    );
  }
}

class _ComicsTablet extends StatelessWidget {
  final String screenName;
  final List<Comic> comics;

  const _ComicsTablet(this.screenName, this.comics);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 80),
      childAspectRatio: 0.86,
      mainAxisSpacing: screenSize.height * 0.04,
      crossAxisCount: 3,
      physics: const BouncingScrollPhysics(),
      children: List.generate(comics.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 60),
          color: AppTheme.marvelRed,
          child: _ImageCard(screenName, comics[index]),
        );
      }),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final String screenName;
  final Comic comic;

  const _ImageCard(this.screenName, this.comic);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final favoritesService = Provider.of<FavoritesService>(context);

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppTheme.marvelGreyDark,
            boxShadow: [
              BoxShadow(color: AppTheme.marvelWhite, blurRadius: 25, offset: Offset(-5, 4), blurStyle: BlurStyle.outer),
              BoxShadow(color: AppTheme.marvelGreyDark, offset: Offset(-1, 1)),
              BoxShadow(color: AppTheme.marvelGreyDark, offset: Offset(-2, 1)),
              BoxShadow(color: AppTheme.marvelGreyDark, offset: Offset(-3, 2)),
              BoxShadow(color: AppTheme.marvelGreyDark, offset: Offset(-4, 3)),
              BoxShadow(color: AppTheme.marvelGreyDark, offset: Offset(-5, 4)),
              BoxShadow(color: AppTheme.marvelGreyDark, blurRadius: 5, offset: Offset(-5, 4)),
            ]
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                favoritesService.isFavorite(comic);
                final isFavorite = favoritesService.isFavoriteSelectedComic;

                Navigator.pushNamed(context, ComicDetailsScreen.routerName, arguments: ComicForDetailsModel(screenName, comic, isFavorite));
              },
              child: Hero(
                tag: '${comic.id}-${screenName}',
                child: Container(
                  child: comic.images.isNotEmpty
                    ? FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        image: NetworkImage('${comic.images.first.path}.${comic.images.first.extension.name.toLowerCase()}'))
                    : const Image(            
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/no-image.jpg'),)
                ),
              ),
            ),
            const Divider(
              color: AppTheme.marvelWhite,
              thickness: 2,
              height: 2,
            ),
            const SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                comic.title,
                textAlign: TextAlign.center,
                maxLines: 2, 
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.robotoCondensed(
                  fontStyle: FontStyle.normal, 
                  fontWeight: FontWeight.w800, 
                  fontSize: 20, 
                  color: AppTheme.marvelWhite
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}