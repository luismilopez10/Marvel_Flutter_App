import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_comics/models/models.dart';

class ComicsService extends ChangeNotifier {
  final _baseUrl = 'gateway.marvel.com:443';
  final _ts = '1';
  final _apikey = '2ea7eb9be7d80c317d179439c8d655a0';
  final _hash = 'a7b33cb2ba87e5b7607657916b9d37cf';
  final _limit = 20;
  int _comicsPage = 0;
  bool isBusy = false;

  List<Comic> comics = [];

  ComicsService(){
    getComics();
  }
  
  getComics() async {
    isBusy = true;
    notifyListeners();

    int offset = 20 * _comicsPage;
    _comicsPage++;
    print('Fetching more comics');
    
    final url = Uri.https(_baseUrl, '/v1/public/comics',
      {'ts': _ts, 
      'apikey': _apikey, 
      'hash': _hash,
      'offset': '$offset',
      'limit': '$_limit'});
    final response = await http.get(url);

    final comicsResponse = comicsResponseFromMap(response.body);

    this.comics.addAll(comicsResponse.data.results);

    isBusy = false;
    notifyListeners();
  }
}