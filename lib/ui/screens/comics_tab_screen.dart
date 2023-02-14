import 'package:flutter/material.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ComicsTabScreen extends StatefulWidget {
  static const String routerName = 'ComicsTab';

  @override
  State<ComicsTabScreen> createState() => _ComicsTabScreenState();
}

class _ComicsTabScreenState extends State<ComicsTabScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final comics = Provider.of<ComicsService>(context).comics;
    final useMobileLayout = MediaQuery.of(context).size.shortestSide < 550;

    return SafeArea(
      child: Stack(
        children: [
          ComicsBackground(),
          useMobileLayout
            // ? _ComicsMobile(screenName, comics)
            ? ComicsMobileColumns(ComicsTabScreen.routerName, comics)
            : ComicsTablet(ComicsTabScreen.routerName, comics),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}