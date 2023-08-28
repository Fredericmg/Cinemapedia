import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

//      ----> Creamos una clase que extienda del Domain <----      \
class LocalStorageRepositoryImpl extends LocalStorageRepository {
//un método que cambie el DataSource del Domain devolviéndonos un valor.
  final LocalStorageDatasource datasource;
// Y creamos el constructor ctrl + .de este datasource;
  LocalStorageRepositoryImpl(this.datasource);

  @override
//      --> Creamos sus implementaciones <--      \
// Pulsamos en el nombre de la clase ctrl + .
// Seran los Future o metodos creados en el Repositorio Domain
//      --> Aqui podemos mandar un Id de la pelicula selec. <--      \
  @override
  Future<bool> isMovieFavorite(int movieId) {
// Devolveremos el metodo datasource que es el de la función
// con la accion del future y su contexto
// movieId en este caso
    return datasource.isMovieFavorite(movieId);
  }
//      --> Aqui podemos mandar una cantidad <--      \
  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
// Devolveremos el metodo datasource que es el de la función
// con la accion del future y su contexto
// limit: y offset; en este caso
// apesar que son opcionale pq tiene un valor
// devolveremos el que tengamos
    return datasource.loadMovies(limit: limit, offset: offset);
  }
//      --> Aqui podemos mandar la pelicula <--      \
  @override
  Future<void> toggleFavorite(Movie movie) {
// Devolveremos el metodo datasource que es el de la función
// con la accion del future y su contexto
// movie en este caso
    return datasource.toggleFavorite(movie);
  }
}
