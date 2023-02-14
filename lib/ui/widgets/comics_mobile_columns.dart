import 'package:flutter/material.dart';
import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/theme/app_theme.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';

class ComicsMobileColumns extends StatelessWidget {
  final String screenName;
  final List<Comic> comics;

  const ComicsMobileColumns(this.screenName, this.comics);

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
          child: ComicCard(screenName, comics[index]),
        );
      }),
    );
  }
}