import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/services/services.dart';

class ComicDetailsScreen extends StatelessWidget {
  static const String routerName = 'ComicDetails';
  
  @override
  Widget build(BuildContext context) {
    final forDetailsModel = ModalRoute.of(context)!.settings.arguments as ComicForDetailsModel;
    final comic = forDetailsModel.comic;
    final screenName = forDetailsModel.screenName;
    final isFavorite = forDetailsModel.isFavorite;
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 550;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _CustomAppBar(comic),
          SliverList(
            delegate: SliverChildListDelegate([
              useMobileLayout
                ? _ComicDetailsMobile(screenName, comic, isFavorite)
                : _ComicDetailsTablet(screenName, comic, isFavorite),              
              SizedBox(height: screenSize.height * 0.03,),
              _VariantCovers(comic.images),
              SizedBox(height: screenSize.height * 0.05,),
            ]),
          ),
        ],
      ),
    );
  }
}

// Common for both Mobile and Tablet UI

class _CustomAppBar extends StatelessWidget {
  final Comic comic;

  const _CustomAppBar(this.comic);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SliverAppBar(
      expandedHeight: screenSize.height * 0.2,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: 1,
        titlePadding: const EdgeInsets.symmetric(horizontal: 0),
        title: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 20, left: screenSize.width * 0.12, right: screenSize.width * 0.05),
          color: Colors.black26,
          child: Text(comic.title, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center,),
        ),
        background: comic.images.isNotEmpty
          ? FadeInImage(
            placeholder: const AssetImage('assets/images/loading.gif'),
            image: NetworkImage('${comic.images.first.path}.${comic.images.first.extension.name.toLowerCase()}'),
            fit: BoxFit.cover,
            )
          : const Image(            
              image: AssetImage('assets/images/no-image.jpg'),
              fit: BoxFit.cover,
            ),
      ),
    );
  }
}

class _VariantCovers extends StatelessWidget {
  final List<Thumbnail> variantCovers;

  const _VariantCovers(this.variantCovers);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return variantCovers.isEmpty
      ? Container()
      : Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width *0.03),
      child: Container(
        width: double.infinity,
        height: screenSize.height * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Variant Covers:',style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 20,),),
            SizedBox(height: screenSize.height * 0.02,),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: variantCovers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context, 
                        builder: (_) {
                          return Dialog(
                            child: Container(
                              color: Colors.black,
                              width: screenSize.width * 0.8,
                              height: screenSize.height * 0.8,
                              child: Swiper(
                                physics: const BouncingScrollPhysics(),
                                index: index,
                                itemCount: variantCovers.length,
                                loop: false,
                                itemBuilder: (context, index) {
                                  return FadeInImage(
                                    fit: BoxFit.contain,
                                    placeholder: const AssetImage('assets/images/loading.gif'),
                                    image: NetworkImage('${variantCovers[index].path}.${variantCovers[index].extension.name.toLowerCase()}'),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                      width: screenSize.width * 0.36,
                      child: FadeInImage(
                        fit: BoxFit.contain,
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        image: NetworkImage('${variantCovers[index].path}.${variantCovers[index].extension.name.toLowerCase()}'),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  final Comic comic;
  // final bool isFavorite;

  const _Buttons({required this.comic});


  @override
  Widget build(BuildContext context) {
    final isFavorite = Provider.of<FavoritesService>(context).isFavoriteSelectedComic;
    
    return Row(
      children: [
        IconButton(
          tooltip: 'Share',
          icon: const Icon(Icons.share_outlined, size: 30,),
          onPressed: () {
            Share.share(comic.urls.first.url, subject: 'Check out this Comic!');
          },
        ),
        IconButton(
          tooltip: 'Favorite',
          icon: isFavorite
            ? Icon(Icons.star, size: 30, color: Colors.amber[600])
            : const Icon(Icons.star_outline, size: 30,),
          onPressed: () {            
            final favoritesService = Provider.of<FavoritesService>(context, listen: false);
            
            if (isFavorite) {
              favoritesService.deleteFavoriteComic(comic);
              return;
            }
            
            favoritesService.saveFavoriteComic(comic);
          },
        ),
      ],
    );
  }
}

// Mobile UI widgets

class _ComicDetailsMobile extends StatelessWidget {
  final String screenName;
  final Comic comic;
  final bool isFavorite;

  const _ComicDetailsMobile(this.screenName, this.comic, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
      child: _PosterAndTitleMobile(screenName, comic, isFavorite),
    );
  }
}

class _PosterAndTitleMobile extends StatelessWidget {
  final String screenName;
  final Comic comic;
  final bool isFavorite;

  const _PosterAndTitleMobile(this.screenName, this.comic, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final publishedDate = DateTime.parse(comic.dates.first.date);
    final publishedDateFormatted = DateFormat("MMMM d, y").format(publishedDate);
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.03),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: '${comic.id}-${screenName}',
                child: comic.images.isNotEmpty
                ? FadeInImage(
                    placeholder: const AssetImage('assets/images/loading.gif'),
                    image: NetworkImage('${comic.images.first.path}.${comic.images.first.extension.name.toLowerCase()}'),
                    width: screenSize.width * 0.25,
                  )
                : Image(            
                    image: const AssetImage('assets/images/no-image.jpg'),
                    width: screenSize.width * 0.25,
                  ),
              ),
              SizedBox(width: screenSize.width * 0.04,),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenSize.width * 0.62),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comic.title,overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.robotoCondensed(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 20,),
                    ),
                    const SizedBox(height: 19,),
                    Row(
                      children: [
                        Text('Price:',style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 18,),
                        ),
                        const SizedBox(width: 5,),
                        Text('\$${comic.prices.first.price}',style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,),
                        ),
                        const SizedBox(width: 25,),
                        Text('Pages:',style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 18,),
                        ),
                        const SizedBox(width: 5,),
                        Text('${comic.pageCount}',style: GoogleFonts.roboto(fontStyle: FontStyle.normal,fontWeight: FontWeight.w400,fontSize: 16,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 19,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Published:',textAlign: TextAlign.justify,style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 20,),
                            ),
                            Text(publishedDateFormatted, textAlign: TextAlign.justify, style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,),
                            ),
                          ],
                        ),
                        _Buttons(comic: comic),
                      ],
                    ),
                  ],
                ),
              )
            ]
          ),
          SizedBox(height: screenSize.height * 0.03,),
          comic.description != null && comic.description!.isNotEmpty
          ? Text(comic.description!,textAlign: TextAlign.justify,style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,))
          : Container()
        ],
      ),
    );
  }
}

// Tablet UI widgets

class _ComicDetailsTablet extends StatelessWidget {
  final String screenName;
  final Comic comic;
  final bool isFavorite;

  const _ComicDetailsTablet(this.screenName, this.comic, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
      child: Column(
        children: [
          _PosterAndTitleMobile(screenName, comic, isFavorite),
        ],
      ),
    );
  }
}

class _PosterAndTitleTablet extends StatelessWidget {
  final String screenName;
  final Comic comic;
  final bool isFavorite;

  const _PosterAndTitleTablet(this.screenName, this.comic, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final publishedDate = DateTime.parse(comic.dates.first.date);
    final publishedDateFormatted = DateFormat("MMMM d, y").format(publishedDate);
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: comic.id,
            child: comic.images.isNotEmpty
            ? FadeInImage(
              placeholder: const AssetImage('assets/images/loading.gif'),
              image: NetworkImage('${comic.images.first.path}.${comic.images.first.extension.name.toLowerCase()}'),
              height: screenSize.height * 0.2,
              )
            : Image(            
                image: const AssetImage('assets/images/no-image.jpg'),
                height: screenSize.height * 0.2,
              ),
          ),
          SizedBox(width: screenSize.width * 0.04,),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenSize.width * 0.63),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comic.title, overflow: TextOverflow.ellipsis,maxLines: 2, style: GoogleFonts.robotoCondensed(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 20,),
                ),
                const SizedBox(height: 19,),
                Row(
                  children: [
                    Text('Price:',style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 18,),
                    ),
                    const SizedBox(width: 5,),
                    Text('\$${comic.prices.first.price}',style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,),
                    ),
                    const SizedBox(width: 25,),
                    Text('Pages:',style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 18,),
                    ),
                    const SizedBox(width: 5,),
                    Text('${comic.pageCount}',style: GoogleFonts.roboto(fontStyle: FontStyle.normal,fontWeight: FontWeight.w400,fontSize: 16,),
                    ),
                  ],
                ),
                const SizedBox(height: 19,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('On Sale Date:',textAlign: TextAlign.justify,style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w800, fontSize: 20,),
                        ),
                        Text(publishedDateFormatted, textAlign: TextAlign.justify, style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,),
                        ),
                      ],
                    ),
                    _Buttons(comic: comic),
                  ],
                ),
                const SizedBox(height: 19),
                comic.description != null && comic.description!.isNotEmpty
                ? Text(comic.description!,textAlign: TextAlign.justify,style: GoogleFonts.roboto(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16,))
                : Container()
              ],
            ),
          )
        ]
      ),
    );
  }
}