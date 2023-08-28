import 'package:cinemapedia/domain/entities/actores.dart';
import 'package:cinemapedia/presentation/providers/actores/actores_repositorie_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Devemos añadir de que tipo es nombres clase creada.
// ActorMapNotifier y el objeto sera tipo mapa
// el mapa es de <palabras y peliculas o puede ser lista
// <ActorMapNotifier, Map<String, List<Actores>>>
final actoresByMovieProviders =
    StateNotifierProvider<ActorMapNotifier, Map<String, List<Actores>>>((ref) {
// Creamos el metodo de donde llamaremos a las peliculas
// dentro del StateNotifierProvider
// Debemos observar el Provider inmutable
  final actoresReprositorio = ref.watch(actoresRepositoryProvider);
// Devuelve de el metodo de la clase creada StateNotifier
// entre parentesis la funcion de metodo creado en el StateNotifier
// con peticion del metodo del StateNotifierProvider.
// y . la funcion del repositorio de infraestructura sin ()
  return ActorMapNotifier(getActores: actoresReprositorio.getActoresByMovie);
});

// Esta funcion debe regresar = un Future de actores
// que sera una funcion de palabras movieId
typedef GetActoresCallback = Future<List<Actores>> Function(String movieID);

// Creamos una clase que extienda de statenotifier
// El StateNotifier es un mapa de palabras de lista de actores (entidades)
class ActorMapNotifier extends StateNotifier<Map<String, List<Actores>>> {
// Creamos un metodo final
  final GetActoresCallback getActores;
// y creamos el constructor de super vacio pq al principio el
// mapa esta vacio
  ActorMapNotifier({required this.getActores}) : super({});
// Creamos un Future que es de donde vendran
// las peticiones de pelicula
// sera vacio con una funcion asincrona de movieId
  Future<void> loadActores(String movieId) async {
// Creamos una condición del stado [] (esto es lista)
// si hay pelicula no hagas nada
    if (state[movieId] != null) return;
// de lo contrario (si hay actores)
// await (espera y haz una petición)
    final List<Actores> actores = await getActores(movieId);
    state = {...state, movieId: actores};
  }
}
