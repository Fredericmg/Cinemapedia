import 'package:cinemapedia/domain/entities/actores.dart';
// Creamos una clase abstracta
abstract class ActoresRepositories {
// Definimos las reglas de este DataSource
// Sera un Future de una lista de <actores> y la accion
// getActorsByMovie regresa una palabras de movieId
Future<List<Actores>> getActoresByMovie(String movieId);
}
