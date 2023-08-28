import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Devemos añadir de que tipo es
// MovieMapNotifier y el objeto sera tipo mapa
// el mapa es de palabras y peliculas
// <MovieMapNotifier, Map <String , Movie>>
final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map <String , Movie>>((ref) {
// Creamos el metodo de donde llamaremos a las peliculas
  final movieReprositorio = ref.watch(movieRepositoryProvider);
// Devuelve de el metodo creado o deseado
  return MovieMapNotifier(getMovie: movieReprositorio.getMovieId);
});

// Esta funcion debe regresar = un Future de peliculas
// que sera una funcion de palabras movieId
typedef GetMovieCallback = Future<Movie> Function(String movieID);

// Creamos una clase que extienda de statenotifier
// El StateNotifier es un mapa de palabras de peliculas
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
// Creamos un metodo final
  final GetMovieCallback getMovie;
// y creamos el constructor de super vacio
  MovieMapNotifier({required this.getMovie}) : super({});
// Creamos un Future que es de donde vendran
// las peticiones de pelicula
// sera vacio con una funcion asincrona de movieId
  Future<void> loadMovie(String movieId) async {
// Creamos una condición del stado []
// si hay pelicula no hagas nada
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
