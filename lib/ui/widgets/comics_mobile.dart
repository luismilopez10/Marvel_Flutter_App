import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';

class ComicsMobile extends StatefulWidget {
  final String screenName;
  final List<Comic> comics;
  final Function onNextPage;

  const ComicsMobile({
    required this.screenName, 
    required this.comics, 
    required this.onNextPage
  });

  @override
  State<ComicsMobile> createState() => _ComicsMobileState();
}

class _ComicsMobileState extends State<ComicsMobile> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const comicScale = 0.9;

    return Swiper(
      // controller: scrollController,
      itemCount: widget.comics.length,
      viewportFraction: 1.0,
      layout: SwiperLayout.STACK,
      itemWidth: screenSize.width * 0.73 * comicScale,
      itemHeight: screenSize.height * 0.70 * comicScale,
      itemBuilder: (context, index) {
        return ComicCard(widget.screenName, widget.comics[index]);
      },
    );
  }
}