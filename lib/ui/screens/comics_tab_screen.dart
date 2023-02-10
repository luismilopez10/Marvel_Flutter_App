import 'package:flutter/material.dart';
import 'package:marvel_comics/services/services.dart';
import 'package:marvel_comics/ui/widgets/card_swiper_widget.dart';
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

    return SafeArea(
      child: Scaffold(
        body: CardSwiper(comics),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}