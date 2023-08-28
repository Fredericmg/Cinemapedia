import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actores_datasource.dart';
import 'package:cinemapedia/domain/entities/actores.dart';
import 'package:cinemapedia/infrastructure/mappers/actores_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

// Creamos una clase que estienda del DataSource del Dominio
// ctrol + . y crea el @override
class ActorMovidbDatasource extends ActoresDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
// lo creamos asincrono
  Future<List<Actores>> getActoresByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
// Creamos un metodo de la lista fromJson (respons.data)
// es respons es el nombre dado en el metodo anterior
    final castResponse = CreditsResponse.fromJson(response.data);
// Y creamos la lista
    List<Actores> actores = castResponse.cast.map(
// devolvemos un actor que lo encontrare en el mapper de actores
        (cast) => ActoresCast.castToEntiti(cast)
// toList es pq creremos que nos devielva una lista controlada
        ).toList();
// Debemos devolver un listado de actores
    return actores;
  }
}
