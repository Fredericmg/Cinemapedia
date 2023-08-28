import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actores_repositorie_impl.dart';

// Este repositorio es inmutable
final actoresRepositoryProvider = Provider((ref) {
// que devuelva una petición al repositorio de infraestructura
// y mandaremos nuestro( datasource de infraestructura)
  return ActoresRepositorieImpl( ActorMovidbDatasource() );
});


