import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getToprated({int page = 1});

//* Movies //Peticion a palabras del id
  Future<Movie> getMovieId(String id);

//* Busquedas //Pericion a palabras de consulta (query)
  Future<List<Movie>> searchMovies(String query);
}
