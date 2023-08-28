import 'package:cinemapedia/domain/datasources/actores_datasource.dart';
import 'package:cinemapedia/domain/entities/actores.dart';
import 'package:cinemapedia/domain/repositories/actores_repositories.dart';

// Creamos una clase que extienda del reporitoro del dominio
class ActoresRepositorieImpl extends ActoresRepositories {
// Creamos un metodo que nos llame el DataSource del dominio
  final ActoresDataSource dataSource;
// Creamos constructor ctrl + .
  ActoresRepositorieImpl(this.dataSource);

// ctrl + . implementacion del override
  @override
  Future<List<Actores>> getActoresByMovie(String movieId) {
// Devolvemos el dataSource del metodo con la funcion 
// que hay en el dominio y el valor buscado en este(en este)
    return dataSource.getActoresByMovie(movieId);
  }
}
