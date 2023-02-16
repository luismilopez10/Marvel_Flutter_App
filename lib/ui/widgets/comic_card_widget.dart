import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics/ui/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/theme/app_theme.dart';

class ComicCard extends StatelessWidget {
  final String screenName;
  final Comic comic;

  const ComicCard(this.screenName, this.comic);

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 15,),
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
                  fontSize: 16, 
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
