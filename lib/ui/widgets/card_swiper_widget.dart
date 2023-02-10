import 'package:flutter/material.dart';

import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/theme/app_theme.dart';

class CardSwiper extends StatelessWidget {
  final List<Comic> comics;

  const CardSwiper(this.comics);

  @override
  Widget build(BuildContext context) {
    final comics = Provider.of<ComicsService>(context).comics;
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 550;

    return Container(
      child: useMobileLayout
        ? _ComicsMobile(comics)
        : _ComicsTablet(comics),
    );
  }
}

class _ComicsMobile extends StatelessWidget {
  final List<Comic> comics;

  const _ComicsMobile(this.comics);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Swiper(
      itemCount: comics.length,
      layout: SwiperLayout.STACK,
      itemWidth: screenSize.width * 0.73,
      itemHeight: screenSize.height * 0.70,
      itemBuilder: (context, index) {
        return _ImageCard(comics[index]);
      },
    );
  }
}

class _ComicsTablet extends StatelessWidget {
  final List<Comic> comics;

  const _ComicsTablet(this.comics);

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
          child: _ImageCard(comics[index]),
        );
      }),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Comic comic;

  const _ImageCard(this.comic);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppTheme.marvelRed,
        ),
        Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              child: Container(
                child: comic.images.isNotEmpty
                  ? FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/images/giphy.gif'),
                      image: NetworkImage('${comic.images.first.path}.${comic.images.first.extension.name.toLowerCase()}'))
                  : const Image(            
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/no-image.jpg'),)
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }
}