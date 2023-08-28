import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Creamos un provider con un String Vacio
final searchQueryProvider = StateProvider<String>((ref) => '');

// Crearemos un nuevo Provider que tenga <Norifier y el state>
// creamos la implementación del StateNotifier
// notifier = el nombre de la clase
// y el estado sera una lista de las entidades (Movie)
final searchMoviesProvider =
    StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
// Implementación creamos una clase
// la implementacion si bajas veras que es la clase ya lo he marcado
// Creamos el metodo a usar en el screen que deseamos
final movieRepository = ref.read(movieRepositoryProvider);
  return SearchMoviesNotifier(
    searchMovies: movieRepository.searchMovies, 
    ref: ref);
});

// Creamos una funcion personalizada
// que sera igual a una Future lista de peliculas
// y realiza una función que nos devuelva String de consulta
typedef SearchMoviesCallback = Future<List<Movie>> Function(String quety);

// esta es al Implementación
// sera una clase que extienda de
// StateNotifier de una lista de peliculas de nuestra entidades
class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
// creamos el metodo del typedef
// sin final ni nada solo es para activarlo en la clase
  final SearchMoviesCallback searchMovies;
// para tener acceso al Ref
  final Ref ref;
// Llamamos al constructor ctrol + .
// sera de un arreglo vacio de una lista ([])
  SearchMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);
// El metodo es lo que hace este River
// Sera un Future que regrese la List de pelicula
// este se llamara searchMoviesByQuery(buscar peliculas por consulta)
// sonde reciviremos el String query
  Future<List<Movie>> searchMovieByQuery(String query) async {
// creamos el metodo para usar en el Future del SearchMoviesCallback
// sera una lista de pelicula de las entidades, con una acción entre ()
// y pedimos el String query requerido por searchMovieByQuery
// estas son las peliculas que he metido en el estado
    final List<Movie> movies = await searchMovies(query);
// usamos la propiedad ref que he creado colocandolo como metodo del
// Future y en el String es el valor de query
    ref.read(searchQueryProvider.notifier).update((state) => query);
// por lo tanto es estado sera igual a las peliculas
    state = movies;
// devolvera una lista []
// sw peliculas
    return movies;
  }
}
