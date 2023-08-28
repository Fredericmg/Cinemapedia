import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0', 
  
  routes: [
// Rutas de navegación
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        //funcion con cuerpo
      // --> Metodo para derterminar la page: <--      \
// si no hay (??) sera = a 0
        final pageIndex = int.parse(state.params['page'] ?? '0');
// devolveremos el metodo con la extension (int).parse
// parse es (analizar), y entonces devuelve
        return HomeScreen(pageIndex: pageIndex,);
      },
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
// Creamos un metodo para utilizar en el movieId:
// lo haremos de modo opcional pq
// puede ser que lo tngamos o no
              final movieId = state.params['id'] ?? 'no Id';

// devolvemos el valor que queremos
              return MovieScreen(
                movieId: movieId,
              );
            }),
      ]),
//      ----> Debemos redirigir fuera del CustomButtonNavigation <----      \
//      -->                   a otra ruta dirigia                  <--      \
        GoRoute(
          path: '/',
// Redirect: context i state pero como no me interesan pongo _ i __
          redirect: ( _ , __ ) => '/home/0',  
        ),
]);


