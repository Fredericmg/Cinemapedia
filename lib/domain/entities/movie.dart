//      ----> Hacemos la implementación de Isar en las entidades<----      \
// importamos el paquete de Isar y
// colocamos el part 'user.g.dart';
// generara un archivo independiente
import 'package:isar/isar.dart';
part 'movie.g.dart';


//-> Colocamos el @collection <--      \
//-> y el Id de Isar
@collection
class Movie {
  ////Id id = Isar.autoIncrement;
// pero lo hago opcional (?)
  Id? isarId;
  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});
}
