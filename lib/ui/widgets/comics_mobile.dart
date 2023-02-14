import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';

class ComicsMobile extends StatelessWidget {
  final String screenName;
  final List<Comic> comics;

  const ComicsMobile(this.screenName, this.comics);

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
        return ComicCard(screenName, comics[index]);
      },
    );
  }
}