import 'package:cinemapedia/infrastructure/models.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';

import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

// Creamos una funcion para ahorrar codigo
// Crearemos una lista de peliculas con un nombre
// que este sera un mapa  de palabras dinamico de json
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
// Creamos el metodo el json sera = a la respuesta de dio
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
// aqui estoy reciviendo la pagina pero no llamo a todas
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing',
// aqui llamaremos https://api.themoviedb.org/3/movie/now_playing?api_key=e8c9405624355846bf03ea6289259643&language=es-MX&page=45)a todas la paginas
        queryParameters: {'page': page});
// Retornaremos la funcion creada con el json del dio
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular',
// aqui llamaremos https://api.themoviedb.org/3/movie/now_playing?api_key=e8c9405624355846bf03ea6289259643&language=es-MX&page=45)a todas la paginas
        queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getToprated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated',
// aqui llamaremos https://api.themoviedb.org/3/movie/now_playing?api_key=e8c9405624355846bf03ea6289259643&language=es-MX&page=45)a todas la paginas
        queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming',
// aqui llamaremos https://api.themoviedb.org/3/movie/now_playing?api_key=e8c9405624355846bf03ea6289259643&language=es-MX&page=45)a todas la paginas
        queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieId(String id) async {
// Creamos un metrodo
    final response = await dio.get(
      '/movie/$id',
    );
// Creamos la condicion de si hay id o no
// es por si buscamos una pelicula que no existe
// si el statusCode es diferente a 200 entonces manda una
// escepcion throw que sera un texto
    if (response.statusCode != 200) throw Exception('Movie id: $id no found');
// Creamos un mapeo de FromJson
    final movieDetails = MovieDetails.fromJson(response.data);
// Y ahora el mapper
    final Movie movie = MovieMapper.movieDetailsToEntiti(movieDetails);
// Queremos devolver una movie del maper
    return (movie);
  }

  // Lo haremos asincrono
  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get('/search/movie',
// aqui llamaremos https://api.themoviedb.org/3/search/movie?api_key=e8c9405624355846bf03ea6289259643&language=es-MX&page=45)a todas la paginas
        queryParameters: {'query': query});
    return _jsonToMovies(response.data);
  }
}
