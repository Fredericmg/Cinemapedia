// Importaremos material
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

// Creamos un SLW
// Convertimos el SLW en un SFW
// Convertimos el SFW por un CSFW
class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';
//  Creamos un metodo que sera requerido
  final String movieId;

// Creamos el constructor obligatorio
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
// Utilizacion del Provider
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actoresByMovieProviders.notifier).loadActores(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
// Creamos un metodo que sirve para hacer las peticiones
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
// Creamos una peticion
// si es nulo que haremos {esto}
    if (movie == null) {
      return const Scaffold(
          body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ));
    }
// si esta cargado harmos esto otro
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppbar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => MovieDescription(movie: movie),
            childCount: 1, // Numero de repeticiones lista
          ))
        ],
      ),
    );
  }
}

class MovieDescription extends StatelessWidget {
// de donde proviene la información
  final Movie movie;
// Creamos el constructor
  const MovieDescription({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
// Generamos el tamaño del Dispositivo Movil
    final size = MediaQuery.of(context).size; // Tomar Medida del Dispositivo
// Creamos un estilo de letra tamaño
// si no continuas con . en el texrTheme lo puedes hacer
// en cada Texto
    final textstyle = Theme.of(context).textTheme; // Pon title large u otro

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(8)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    movie.posterPath,
                    width: size.width * 0.3, //utilizamos el 30% pantalla
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
// Colocamos la medida que nos queda
// MediaQuery - 8 - 10 - 30
              width: (size.width - 48) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textstyle.titleLarge?.copyWith(color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    movie.overview,
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
// Combinacion Row+Column
          child: Wrap(
            // crossAxisAlignment: WrapCrossAlignment.center ,
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Casting',
              style: textstyle.titleLarge,
            )),
        const SizedBox(
          height: 10,
        ),
        _ActoresByMovie(movieId: movie.id.toString()),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

//-> 1-.Cambiamos el SLW por el COnsumerWidget
class _CustomSliverAppbar extends ConsumerWidget {
// Creamos unos metodos de peticion peliculas
  final Movie movie;
// Creamos el constructor
  const _CustomSliverAppbar({
    required this.movie,
  });

  @override
// -> 2-.Tambien colocamos el WidgetRef ref
// para que entienda que voy a usar un RiverPod
  Widget build(BuildContext context, WidgetRef ref) {
// siempre dentro del widget
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
//      ----> Colocamos la accion de actions: <----      \
// Asi colocaremos el icono del corazon-
      actions: [
        IconButton(
            onPressed: () {
// -> 3-.Hacemos referencia al RiverPod
// seguiremos de un . para usar el que queramos de los creados
              ref.watch(localStorageRepositoryProvider).toggleFavorite(movie);
            },
            //Todo el icono cambiara de al pulsarlo
            icon: const Icon(Icons.favorite_border_outlined)
            // icon: const Icon(Icons.favorite, color: Colors.red,)
            ),
      ],
      backgroundColor: Colors.black, //Color de fondo
      expandedHeight: size.height * 0.7, //Tamaño AppBar
      foregroundColor: Colors.white, // Color Texto
      flexibleSpace: FlexibleSpaceBar(
// Separación del texto con los margenes
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// cogemos un parametro de la pelicula el //*TITULO
        //* title: Text(
        //*   movie.title,
        //*   style: const TextStyle(fontSize: 20), //tamaño letra
        //*   textAlign: TextAlign.start, //alineacion texto
        //* ),
        background: Stack(children: [
//* Imagen
// Creamos una Sizebox para que ocupe todo el espacio
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
// Genera un fondo negro a imagen
              loadingBuilder: (context, child, loadingProgress) {
// si loadingProgress es nulo regresa un SizeBox()
                if (loadingProgress != null) return const SizedBox();
// de lo contrario
                return FadeIn(child: child);
              },
            ),
          ),
//* Gradiente inferior
// Creamos un gradiente inf. para ver letras blancas
          const _CustomGradient(
              begin: Alignment.topCenter, //inicio Gradiente
              end: Alignment.bottomCenter, //final Gradiente
              stops: [
                0.7,
                1.0
              ],
              colors: [
                Colors.transparent,
                Colors.black87,
              ]),

//* Gradiente superior
// Creamos un gradiente sup. para ver letras blancas
          const _CustomGradient(begin: Alignment.topLeft, stops: [
            0.0,
            0.4
          ], colors: [
            Colors.black87,
            Colors.transparent,
          ]),

//* Gradiente corazón
// Creamos un gradiente sup. para ver letras blancas
          const _CustomGradient(
              // begin: Alignment.topRight, //inicio Gradiente
              begin: AlignmentDirectional.bottomCenter, //inicio Gradiente
              end: Alignment.bottomLeft, // fin Gradiente
              stops: [
                0.0,
                0.2
              ],
              colors: [
                Colors.black,
                Colors.transparent,
              ])
        ]),
      ),
    );
  }
}

class _ActoresByMovie extends ConsumerWidget {
// creamos el metodo
  final String movieId;
// Creamos el constructor
  const _ActoresByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
// Creamos un metodo = referencia del Provider
    final actoresByMovie = ref.watch(actoresByMovieProviders);
// Creamos una condicion para saber si los actores estan cargados
// si metodo del metodo del consumerwidget es nulo enonces{}
    if (actoresByMovie[movieId] == null) {
// entonces
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }
// Creamos un metodo que ya cumple que la peticion anterior
// es correcta forzaremos con !
    final actores = actoresByMovie[movieId]!;
// de lo contrario
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actores.length,
        itemBuilder: (context, index) {
// Creamos un metodo de busqueda en la posicion indice []
          final actor = actores[index];
// Y devolveremos el widget a mostrar
          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      fit: BoxFit.cover,
                      height: 180,
                      width: 135,
                    ),
                  ),
                ),
                Text(
                  actor.name,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? '', // este puede ser nulo solucion ??''
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin; // para saber el tipo de
  final AlignmentGeometry end; // dato deja el cursor encima
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft, // se pone el de serie
      this.end = Alignment.bottomRight, // se pone el de serie
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: begin, //inicio Gradiente
                end: end, // fin Gradiente
                stops: stops,
                colors: colors)),
      ),
    );
  }
}
