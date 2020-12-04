import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:movies_app/src/models/actors_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/models/person_cast_model.dart';

class MoviesProvider {
  String _apikey = '66e60311159e6e3b25bbf0e38caa0c58';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';
  int _page = 0;

  List<Movie> _popularMovies = new List();
  bool _loading = false;

  final _popularMoviesStreamController =
      StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularMoviesSink =>
      _popularMoviesStreamController.sink.add;

  Stream<List<Movie>> get popularMoviesStream =>
      _popularMoviesStreamController.stream;

  void disposeStreams() {
    _popularMoviesStreamController?.close();
  }

  Future<List<Movie>> _getResponse(
    Uri url,
  ) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final popularMovies = new Movies.fromJsonList(decodeData['results']);

    return popularMovies.items;
  }

  Future<List<Movie>> getInCinema() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    return await _getResponse(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    if (_loading) return [];

    _loading = true;

    _page++;

    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apikey, 'language': _language, 'page': _page.toString()});

    final response = await _getResponse(url);

    if (response.length < 0) {
      _page = 1;
    }

    _popularMovies.addAll(response);

    popularMoviesSink(_popularMovies);

    _loading = false;

    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final response = await http.get(url);
    //decodifica y crea el mapa
    final decodedData = json.decode(response.body);
    //nueva instancia del modelo
    final casting = new Cast.fromJsonList(decodedData['cast']);

    return casting.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    return await _getResponse(url);
  }

  Future<List<Person>> getPersonInfo(String personId) async {
    final url = Uri.https(_url, '3/person/$personId/movie_credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final response = await http.get(url);
    //decodifica y crea el mapa
    final decodedData = json.decode(response.body);
    //nueva instancia del modelo
    final personFilmsInfo = new PersonCast.fromJsonList(decodedData['cast']);

    return personFilmsInfo.filmsInfo;
  }
}
