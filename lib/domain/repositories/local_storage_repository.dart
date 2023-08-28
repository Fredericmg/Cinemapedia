import 'package:cinemapedia/domain/entities/movie.dart';

//      ----> Creamos una clase abstracta <----      \
abstract class LocalStorageRepository {
// Esta tendra unos metodos
  Future<void> toggleFavorite(Movie movie); // alternar Fav.
// Sera un valor boleano de V o F si tenemos el id
// Como el id es un numero entero pongo int
  Future<bool> isMovieFavorite(int movieId); //pelicula Fav.
// Un Listado de peliculas con un limite de 10 por pantalla
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}