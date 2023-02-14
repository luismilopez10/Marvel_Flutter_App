import 'package:flutter/material.dart';
import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/theme/app_theme.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ComicsMobileColumns extends StatefulWidget {
  final String screenName;
  final List<Comic> comics;
  final Function onNextPage;

  const ComicsMobileColumns({
    required this.screenName, 
    required this.comics, 
    required this.onNextPage
  });

  @override
  State<ComicsMobileColumns> createState() => _ComicsMobileColumnsState();
}

class _ComicsMobileColumnsState extends State<ComicsMobileColumns> {
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

    return GridView.count(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 30),
      childAspectRatio: screenSize.height * 0.00085, // 0.64
      mainAxisSpacing: screenSize.height * 0.04,
      crossAxisCount: 2,
      physics: const BouncingScrollPhysics(),
      children: List.generate(widget.comics.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          color: AppTheme.marvelRed,
          child: ComicCard(widget.screenName, widget.comics[index]),
        );
      }),
    );
  }
}