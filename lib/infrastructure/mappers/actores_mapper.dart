import 'package:cinemapedia/domain/entities/actores.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActoresCast {
// creamos un metodo estatico el nombre de 
// la flecha => sera igual a la entidad y al del estatico
// dentro del parentesis colocaremos el nombre
// de la Clase del modelo que usaremos es CreditsResponse la Lista
// class CreditsResponse {
//final int id;
//final List<Cast> cast;//*Usamos este Cast
//final List<Cast> crew;
  static Actores castToEntiti(Cast cast) =>// el cast es el numbre a usar
      Actores(
        id: cast.id, 
        name: cast.name, 
// al ser opcional crearemos una condicion
        profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        : 'https://www.circumcisionpro.co.uk/wp-content/uploads/2021/05/avatar-profile-picture.jpg', 
        character: cast.character
      );
}
