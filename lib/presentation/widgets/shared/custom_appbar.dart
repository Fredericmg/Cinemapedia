import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/delegates/search_movies_delegates.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textstyle =
        Theme.of(context).textTheme.titleMedium; // Pon title large u otro

    return SafeArea(
        // bottom: false,
// Colocamos un Padding para poder eliminar los espacios
// de arriba de los moviles Noche
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
// Este double.infinity = el maximo que pueda de ancho
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_outlined, color: colors.primary),
            const SizedBox(
              width: 5,
            ),
            Text('Cinemapedia', style: textstyle),
// Colocamos un widget para usar todo el espacio que hay nenos
// los childrens que haya (sirve para ocupar todo el espacio)
            const Spacer(),
            IconButton(
                color: colors.primary,
                onPressed: () {
// Creamos el metodo para poder usar el RiverPod dentro del onPressed
//*                  final movieRepository = ref.read(movieRepositoryProvider);
// llamamos al provider
                  final searchMovies = ref.read(searchQueryProvider);

// añadimos lo que estamos buscando Movie opcional
                  showSearch<Movie?>(
                          query: searchMovies, // usamos el provider
                          context: context,
                          delegate: SearchMovieDelegates(
//funcion con cuerpo y llamad al query
                              initialMovies: const[],
                              searchMovies: ref
                                  .read(searchMoviesProvider.notifier)
                                  .searchMovieByQuery))
                      .then((movie) {
                    // colocamos el then(movie)
// Hacemos una condicion si es nulo nada
                    if (movie == null) return;
// De lo contrario navega
                    context.push('/movie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search)) //IconButton
          ],
        ),
      ),
    ));
  }
}
