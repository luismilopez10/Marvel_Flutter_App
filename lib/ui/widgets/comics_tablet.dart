import 'package:flutter/material.dart';

import 'package:marvel_comics/models/models.dart';
import 'package:marvel_comics/theme/app_theme.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';

class ComicsTablet extends StatefulWidget {
  final String screenName;
  final List<Comic> comics;
  final Function onNextPage;

  const ComicsTablet({
    required this.screenName, 
    required this.comics, 
    required this.onNextPage
  });

  @override
  State<ComicsTablet> createState() => _ComicsTabletState();
}

class _ComicsTabletState extends State<ComicsTablet> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 1000) {
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
      padding: const EdgeInsets.symmetric(vertical: 80),
      childAspectRatio: 0.86,
      mainAxisSpacing: screenSize.height * 0.04,
      crossAxisCount: 3,
      physics: const BouncingScrollPhysics(),
      children: List.generate(widget.comics.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 60),
          child: ComicCard(widget.screenName, widget.comics[index]),
        );
      }),
    );
  }
}