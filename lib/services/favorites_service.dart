import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:marvel_comics/models/models.dart';

class FavoritesService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-f59de-default-rtdb.firebaseio.com';
  final List<Comic> favoriteComics = [];

  final storage = const FlutterSecureStorage();

  bool isLoading = true;
  bool isSaving = false;

  bool _isFavoriteSelectedComic = false;
  bool get isFavoriteSelectedComic => _isFavoriteSelectedComic;
  set isFavoriteSelectedComic(bool value) {
    _isFavoriteSelectedComic = value;
    notifyListeners();
  }
  

  FavoritesService() {
    this.loadComics();
  }

  isFavorite(Comic comic){
    for (var element in favoriteComics) {
      if (element.id == comic.id) {
        isFavoriteSelectedComic = true;
        notifyListeners();
        return;
      }
    }

    isFavoriteSelectedComic = false;
    notifyListeners();
  }

  Future loadComics() async {
    this.isLoading = true;
    favoriteComics.clear();
    notifyListeners();
    
    print(await storage.read(key: 'token'));
    final url = Uri.https(_baseUrl, 'results.json', {
      'auth': await storage.read(key: 'token') ?? ''
    });
    final response = await http.get(url);

    if (response.statusCode != 200) {
      return 'Error loading the comics';
    }

    final Map<String, dynamic> comicsMap = json.decode(response.body);
    comicsMap.removeWhere((key, value) => key == '0');

    final user = await storage.read(key: 'email');
    comicsMap.removeWhere((key, value) => value['user'] != user);
    
    comicsMap.forEach((key, value) {
      final tempComic = Comic.fromMap(value);
      tempComic.firebase_id = key;
      this.favoriteComics.add(tempComic);
    });

    this.isLoading = false;
    notifyListeners();

    return this.favoriteComics;
  }

  Future<String> saveFavoriteComic(Comic newFavComic) async {
    newFavComic.user = await storage.read(key: 'email');

    final url = Uri.https(_baseUrl, 'results.json', {
      'auth': await storage.read(key: 'token') ?? ''
    });
    
    final response = await http.post(url, body: json.encode(newFavComic.toMap()));
    
    if (response.statusCode != 200) {
      return 'Error saving the comic';
    }

    this.isFavoriteSelectedComic = true;
    notifyListeners();

    final decodedData = json.decode(response.body);
    newFavComic.firebase_id = decodedData['name'];

    this.favoriteComics.add(newFavComic);


    return newFavComic.firebase_id!;
  }

  Future<String> deleteFavoriteComic(Comic favComicToDelete) async {
    final url = Uri.https(_baseUrl, 'results/${favComicToDelete.firebase_id}.json', {
      'auth': await storage.read(key: 'token') ?? ''
    });

    final response = await http.delete(url, body: json.encode(favComicToDelete.toMap()));

    if (response.statusCode != 200) {
      return 'Error deleting the comic';
    }

    this.isFavoriteSelectedComic = false;
    notifyListeners();
    
    final index = this.favoriteComics.indexWhere((prod) => prod.id == favComicToDelete.id);
    this.favoriteComics.removeAt(index);


    return favComicToDelete.id.toString();
  }
}
