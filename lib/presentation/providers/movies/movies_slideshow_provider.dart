import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

// Sirve para controlar el SlideShow
// Podemos crear un Provider de solo lectura
// yq las peliculas las manejara el nowPlayingMoviesProvider
// Cono no quiero un dynamic devere poner Provider <List<Movie>>
// y deberemos importar el paquete del dominio
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
// Debomveremos que lo tenemos en home.dart
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
// Creamos una condicion
// si peliculas del cine es = 0 devuelve un arreglo vacio
  if (nowPlayingMovies.isEmpty) return [];
// De lo contrario peluculas de cine de la 0 - 6
  return nowPlayingMovies.sublist(0,7);
});
