import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesHorizontalListview extends StatefulWidget {
// Creamos unos agrumentos
  final List<Movie> movies;
  final String? label; //le pongo ? pq son opcionales
  final String? fecha; //le pongo ? pq son opcionales
  final VoidCallback? loadNextPage; //le pongo ? pq son opcionales

// Crearemos construtor ctrl+.
  const MoviesHorizontalListview(
      {super.key,
      required this.movies,
      this.label,
      this.fecha,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListview> createState() =>
      _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
// metodo de controlador
  final scrollController = ScrollController();

// creamos initState()
  @override
  void initState() {
    super.initState();
// Se crea el oyente
    scrollController.addListener(() {
// Si el loadNextPage es = nada que no haga nada
      if (widget.loadNextPage == null) return;

// creamos la posicion para determinar en la que estamos
// para que sepa que tenemos que añadir mas
// si la posicion es superior +200 sera >= que el maximo que tengamos
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {}
// Por lo tanto cargaremos siguiente pantalla
// en este punto sabemos que tenemos las pantallas (widget.loadNextPage();)
// por lo tanto colocaremos un ! para forzarlo, pq se que no va a ser null
      widget.loadNextPage!();
    });
  }

// creamos dispose()
  @override
  void dispose() {
// se destruye el oyente
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.label != null || widget.fecha != null)
            _Title(label: widget.label, fecha: widget.fecha),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(), // direccion del scroll
            itemBuilder: (context, index) {
// devolvemos el _slide y lo ponemos en el valor index
              return FadeInRight(child: _Slide(movies: widget.movies[index]));
            },
          )),
        ],
      ),
    );
  }
}

// Creamos la clase
class _Slide extends StatelessWidget {
// Creamos metodos
  final Movie movies;

// Creamos el constructor
  const _Slide({required this.movies});

  @override
  Widget build(BuildContext context) {
// Color negrita
    final textstyle = Theme.of(context).textTheme; // Pon title large u otro

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
// Creamos el crosAxis para que todo me que de arriba
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//* Imagen
            SizedBox(
// añadimos un tamaño que queramos
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movies.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
// Creamos condicion
                    if (loadingProgress != null) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
// Hace aparecer imagen por la Derecha
// Aqui añadiremos la ruta al pulsarlo con el widget
// GestureDetector
                    return GestureDetector(
// el ontap con funcion de flecha para realizar la navegación
                      //// onTap: () => context.push('/movie/${movies.id}') ,
                      onTap: () => context.push('/home/0/movie/${movies.id}') ,
                      child: FadeIn(
                        // duration: const Duration(seconds: 1),
                        child: child,
                      ),
                    );
                  },
                ),
              ),
            ),
//* Separación
            const SizedBox(
              height: 5,
            ),
//* Titulo
            SizedBox(
              width: 150,
              child: Text(
                movies.title,
// Vamos a usar color negrita
                style: textstyle.titleSmall,
// Para k no de fallo utilizaremos maxline:
                maxLines: 2,
              ),
            ),
//* Raiting
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    color: Colors.yellow.shade800,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${movies.voteAverage}',
                    style: textstyle.bodyMedium
                        ?.copyWith(color: Colors.yellow.shade800),
                  ),
                  // const SizedBox(width: 10,),
                  const Spacer(),
                  Text(
                    HumanFormat.humanReadNumber(movies.popularity),
                    style: textstyle.bodySmall,
                  ),
                  // Text('${HumanFormat.humanReadNumber(movies.popularity)}', style: textstyle.bodySmall,)
                ],
              ),
            )
          ],
        ));
  }
}

class _Title extends StatelessWidget {
// Creamos unos metodos
  final String? label;
  final String? fecha;

// Creamos el constructos
  const _Title({
    this.label,
    this.fecha,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.titleLarge; // Pon title large u otro
    // final fechaStyle =
    Theme.of(context).textTheme.titleMedium; // Pon title large u otro
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (label != null)
            Text(
              label!,
              style: titleStyle,
            ),
          const Spacer(),
          if (fecha != null)
            FilledButton.tonal(
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
              onPressed: (null),
              child: Text(fecha!),
            ),
        ],
      ),
    );
  }
}
