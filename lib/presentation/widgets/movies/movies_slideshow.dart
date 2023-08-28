import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
// Creamos un metodo final que nos traiga un listado de peliculas
  final List<Movie> movies;

// creamos el constructor ctrl+.
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {

final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(
// Esto es para ver un porcentaje del Slide
          viewportFraction: 0.8,
// Este hace el central mas grande y los otro 0.1 menos
          scale: 0.9,
// Este es para que se vaya moviendo automaticamente
          autoplay: true,
// Añadir una paginacion con icons (...)
          pagination: SwiperPagination(
// Este es el margen entre imagen i paginacion
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              activeColor: colors.primary, //debemos colocar metodo toc
              color: colors.secondary // este es el color de fondo circulo
            )
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) => _Slide(
                movie: movies[index],
              )),
    );
  }
}

class _Slide extends StatelessWidget {
// Creamos un metodo para recivir una pelicula
  final Movie movie;
// creamos el constructor
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
// Nos creamos un metodo para no implemntar tanto el codigo
// solo usando la palabra se hara
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45,
              blurRadius: 10, //es es el difuminado
              offset: Offset(0, 10) //dseplazamiento sombra
              )
        ]);
    return Padding(
// Creamos el bottom para dejar un espacio abajo para colocar ...
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.backdropPath, // De donde viene la imagen
                fit: BoxFit.cover, // esto controlar la imagen
// Sirve para cargar algo si no hay imagen
// Crearemos una condicion if
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    // condicion
                    return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12),
                    );
                  }
                  return FadeIn(child: child); // de lo contrario
                },
              ))),
    );
  }
}

/* // metodo 1 largo
     itemBuilder: (context, index) {
// Creamos un metodo final para recivir una pelicula
          final movie = movies[index];
// devolveremos de este metodo un widget
          return _Slide(movie: movie,);

// Metodo 2
        itemBuilder: (context, index) {
          return _Slide(movie: movies[index],);

// Metodo 3 con funcion de flecha
        itemCount: movies.length,
        itemBuilder: (context, index)=>  _Slide(movie: movies[index],) */
