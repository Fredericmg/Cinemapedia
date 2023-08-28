import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
//      ---> Añadimos el super.key en requerido <---      \\
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
// Aqui llamamos al provider
    final initialLoading = ref.watch(initialLoadingProvider);
// Creamos una condicion
// si initial loading es true que devuelva fullscreenloading
    if (initialLoading) return const FullScreenLoadint();

    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

// este ya se puede borrar
    // return const FullScreenLoadint();

    return CustomScrollView(
// Los childrens = slivers
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
// En la delegacion crearemos una funcion
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
// aqui dentro colocaremos todos los widgets a usar
// menos el que queremos mostrar al desplazar hacia arriba
          return Column(
            children: [
              MoviesSlideshow(movies: moviesSlideshow),
              MoviesHorizontalListview(
                movies: nowPlayingMovies,
                label: 'En Cines',
                fecha: '2023',
                loadNextPage: () {
                  // Leemos el RiverPod nowPlayingMoviesProvider y la funcion
                  // que es loadNextPage
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MoviesHorizontalListview(
                movies: upcomingMovies,
                label: 'Proximamente',
                fecha: 'En este mes',
                loadNextPage: () {
                  // Leemos el RiverPod nowPlayingMoviesProvider y la funcion
                  // que es loadNextPage
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MoviesHorizontalListview(
                movies: popularMovies,
                label: 'Populares',
                fecha: 'En este mes',
                loadNextPage: () {
                  // Leemos el RiverPod nowPlayingMoviesProvider y la funcion
                  // que es loadNextPage
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              MoviesHorizontalListview(
                movies: topRatedMovies,
                label: 'Desde Siempre',
                fecha: 'Vintage',
                loadNextPage: () {
                  // Leemos el RiverPod nowPlayingMoviesProvider y la funcion
                  // que es loadNextPage
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                },
              ),
              const SizedBox(height: 10),
            ],
          ); //Column
        }, childCount: 1) // SilverChildBuilderDelegare
            ), // SilverList
      ],
    ); //CustomScrollView
  }
}

// Eliminacion del Expanded que usamo en el pricipio

/*         Expanded(
          child: ListView.builder(
            itemCount: nowPlayingMovies.length,
            itemBuilder: (context, index) {
              final movie = nowPlayingMovies[index];
              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.originalLanguage),
              );
            },
          ),
        ) */

//     return Column(
//       children: [
//         const CustomAppbar(),
//         MoviesSlideshow(movies: moviesSlideshow),
//         MoviesHorizontalListview(
//           movies: nowPlayingMovies,
//           label: 'En Cines',
//           fecha: '2023',
//           loadNextPage: () {
//             // Leemos el RiverPod nowPlayingMoviesProvider y la funcion
//             // que es loadNextPage
//             ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
//           },
//         ),
//         MoviesHorizontalListview(
//           movies: upcomingMovies,
//           label: 'Proximamente',
//           fecha: 'En este mes',
//           loadNextPage: () {
//             // Leemos el RiverPod nowPlayingMoviesProvider y la funcion
//             // que es loadNextPage
//             ref.read(upcomingMoviesProvider.notifier).loadNextPage();
//           },
//         ),
//         MoviesHorizontalListview(
//           movies: popularMovies,
//           label: 'Populares',
//           fecha: 'En este mes',
//           loadNextPage: () {
//             // Leemos el RiverPod nowPlayingMoviesProvider y la funcion
//             // que es loadNextPage
//             ref.read(popularMoviesProvider.notifier).loadNextPage();
//           },
//         ),
//         MoviesHorizontalListview(
//           movies: topRatedMovies,
//           label: 'Desde Siempre',
//           fecha: 'Vintage',
//           loadNextPage: () {
//             // Leemos el RiverPod nowPlayingMoviesProvider y la funcion
//             // que es loadNextPage
//             ref.read(topRatedMoviesProvider.notifier).loadNextPage();
//           },
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }