import 'package:isar/isar.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

// ----> Creamos una clase que extienda del Domain <---- \
class IsarDatasource extends LocalStorageDatasource {
// --> Creamos la petición de como trabaja isar con un metodo <-- \
// -> 1-.Creamos un metodo late con peticion tardia + const. <- \
  late Future<Isar> db;
  final String directory;
  final String name;
// -> 2-.Creamos el constructor <- \/
// Al ser late y Future el constructor lo hacemos nosotro
// lo haremos con una función para usar cuando queramos
  IsarDatasource(this.directory, this.name) {
    db = openDB();
    // opendDB es un metodo a usar dnd quieras
  } // este es para abrir BD.
// -> 3-. Creación del metodo del constructor
// sera un future de Isar
// Abre la base de datos de isar
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      // que no tenenmos instancia
      return await Isar.open([MovieSchema],
          directory: '$directory/$name.isar', inspector: true);
// el instector = true abre la base de datos
    }
// en es supuesto caso que ya tenga la instancia
//regresaremos la instancia de Isar.obtener instancia
    return Future.value(Isar.getInstance());
  }

// --> Creamos sus implementaciones <-- \
// Pulsamos en el nombre de la clase ctrl + .
// Seran los @override
// -> 4-. Realizaremos las instancias de los override
// siempre haremos una llamada a la BD
// para ello deberemos trabajar en async
  @override
// en este regresare si es favorito o no
  Future<bool> isMovieFavorite(int movieId) async {
// creamos un metodo que haga una llamada a la BD
    final isar = await db; // siempre es isar
// podemos crear mas metodo
// en este caso lo pongo en ? pq puedo o no estar en fav.
    final Movie? isFavoritMovie = await isar.movies
// movies es en plural pq lo ha creado part 'movie.g.dart';
        .filter() //1 quiero que filtres
        .idEqualTo(movieId) //2 cosa iguales al id por lo tanto moviId
        .findFirst(); //y quiero encontrar el primero
    return isFavoritMovie != null;
  }

// -> 4-. Realizaremos las instancias de los override
  @override
// en este regresare un listado de peliculas
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
// creamos un metodo que haga una llamada a la BD
    final isar = await db; // siempre es isar
// movies es en plural pq lo ha creado part 'movie.g.dart';
    return isar.movies
        .where()
        .offset(offset)
        .limit(limit)
        .findAll(); //encontrar todo
  }

// -> 4-. Realizaremos las instancias de los override
  @override
// este escribe y borra en la BD
  Future<void> toggleFavorite(Movie movie) async {
// creamos un metodo que haga una llamada a la BD
    final isar = await db; // siempre es isar
// movies es en plural pq lo ha creado part 'movie.g.dart';
    final favoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movie.id) //regresa toda la pelicula
        .findFirst();
// Creamos una condición si es diferente
    if (favoriteMovie != null) {
// si es diferente borra

      isar.writeTxnSync(() => isar.movies
// es favoriteMovie pq en este punto ya sabe si esta en
// favorito o no por la condicion creada
          .deleteSync(favoriteMovie.isarId!)); //borarr
    }
// si es ugual a favorito añade
    isar.writeTxnSync(() => isar.movies.putSync(movie)); // añadir
  }
}
