import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

// Esta funcion debe regresar = un Future de una lista peliculas
// que sera una funcion de palabras query
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegates extends SearchDelegate<Movie?> {
//  Creamos un metodo para usar el TypeDef
  final SearchMoviesCallback searchMovies;
// Para que funcione el return crearlo sin final
  List<Movie> initialMovies;
// Creación de un controlador debounceMovies (peliculas de rebote)
  final StreamController<List<Movie>> debouncedMovies =
      StreamController.broadcast();
  final StreamController<bool> isLoadingStream = StreamController.broadcast();
// broadcast significa transmición
// Creamos una propiedad para el stream
  Timer? _debounceTimer;

// Creamos su constructor
  SearchMovieDelegates({
    required this.searchMovies,
    required this.initialMovies,
    // this.initialMovies = const[],
  });

// Metodo vacio para limpiar residuos al salir del search
  void _clearStrem() {
    debouncedMovies.close();
  }

//--> metodo para no repetir codigo en susgestion y result <--
  Widget buildResultsAndBuildSusgestion() {
// devolvemos un widget obligatorio
    return StreamBuilder(
      initialData: initialMovies, // ahora si lo colocamos
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
// Creamos un metodo llamado movies que provenga
// del snapshot. de la data
// lo haremos de arreglo vacio de lista con ?? []
        final movies = snapshot.data ?? [];
// Regresamos un ListView.builder
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieSearchItem(
                movie: movies[index],
// Utilizamos la funcion gloval de Flutter que es close
// añadimos el metodo de limpieza dentro de una funcion con cuerpo
// dentro de los () debe tener
// el builder que es el context y lo que buscas
                onMovieSelection: (context, movie) {
                  _clearStrem();
                  close(context, movie);
                });
          },
        );
      },
    );
  }

// Metodo Vacio para el Stream
  void _onQueryChange(String query) {
// si la tranmision es opcional tiene un valor sino es falso
// entonces limpia la transmision con el cancel
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) {
      /* entonces */
      _debounceTimer!.cancel();
    }
// de lo contrario vuelve a hacer un calculo en un timepo determinado
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

//*Palabra que se muestra en el buscador
  @override // para construir un texto en el buscador
  String get searchFieldLabel => 'Buscar Película';

//*Accions
  @override // para construir acciones son como las del appbar
  List<Widget>? buildActions(BuildContext context) {
// devolvemos una lista de widget opcional ?
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
//      ---> SI es Verdadero <---      \ snapshot.data
           return SpinPerfect(
// Creamos una animación y que tenga una durada en aparecer
              duration: const Duration(seconds: 10),
              spins: 10, // vueltas por segundo
              infinite: true, // vueltas infinitas
              child: IconButton(
                  // El query pertenece al SearchDelegate y se puede usar
                  // query significa consulta y lo igualo a nada
                  // por lo tanto query es el buscador la caja de texto
                  //creare un condicion que di esta vacia que no se muestre
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_outlined)),
            );
          }
//      ---> Si es Falso <---      \ ?? false return
          return FadeIn(
// Creamos una animación y que tenga una durada en aparecer
            animate: query.isNotEmpty,
            duration: const Duration(microseconds: 200),
            child: IconButton(
                // El query pertenece al SearchDelegate y se puede usar
                // query significa consulta y lo igualo a nada
                // por lo tanto query es el buscador la caja de texto
                //creare un condicion que di esta vacia que no se muestre
                onPressed: () => query = '',
                icon: const Icon(Icons.clear)),
          );
        },
      )
    ];
  }

//*Leading
  @override // para construir un icono en el inicio
  Widget? buildLeading(BuildContext context) {
// devolvemos un widget opcional ?
    return IconButton(
        onPressed: () {
          _clearStrem(); // llamos al nuevo metodo
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

//* Resultados
  @override // para construir resultados al press enter
  Widget buildResults(BuildContext context) {
// Usamos el metodo creado de widget
    return buildResultsAndBuildSusgestion();
  }

//*Sugerimientos
  @override // para construir la persona esta escriviendo
  Widget buildSuggestions(BuildContext context) {
// implementamos la funcion creada para el stream
    _onQueryChange(query);
// devolvemos un widget obligatorio
//*    return FutureBuilder(
//*      future: searchMovies(query),
// Usamos el metodo creado de widget
    return buildResultsAndBuildSusgestion();
  }
}

class _MovieSearchItem extends StatelessWidget {
// como devo recivir las peliculas me creo un metodo
  final Movie movie;
  final Function onMovieSelection;
// Y añadimos el constructor
  const _MovieSearchItem({required this.movie, required this.onMovieSelection});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Tomar Medida del Dispositivo
    final textstyle = Theme.of(context).textTheme; // Pon title large u otro
// Navegacion dentro del delegate
    return GestureDetector(
// el ontap con funcion
      onTap: () {
        onMovieSelection(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            //* Imagen
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            //*Texto
            SizedBox(
              // width: (size.width - 40) * 0.7,
              width: size.width * 0.65,
              child: FadeIn(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title,
                          maxLines: 2,
                          style: textstyle.titleMedium,
                          overflow: TextOverflow.ellipsis),
                      (movie.overview.length > 100)
                          ? Text('${movie.overview.substring(0, 100)}...')
                          : Text(movie.overview),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star_half_outlined,
                            color: Colors.yellow.shade600,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              HumanFormat.humanReadNumber(movie.voteAverage, 1),
                              style: textstyle.bodyMedium!
                                  .copyWith(color: Colors.yellow.shade800)),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
