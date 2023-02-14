import 'package:flutter/material.dart';

import 'package:marvel_comics/models/comic_model.dart';

class ComicForDetailsModel {
  final String screenName;
  final Comic comic;
  final bool isFavorite;

  ComicForDetailsModel(this.screenName, this.comic, this.isFavorite);
}