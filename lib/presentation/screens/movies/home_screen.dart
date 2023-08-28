import 'package:cinemapedia/presentation/views/movies/popular_view.dart';
import 'package:cinemapedia/presentation/views/view.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
//      --> Metodo para usar las rutas por page: <--      \
// Al ser las rutas por numero lo haremos int
  final int pageIndex; 
//      -->CONSTRUCTOR<--      \
  const HomeScreen({super.key, required this.pageIndex});
//      --> Creación de un Listado de widgets de destino <--      \
  final viewRoutes = const <Widget>[
    // son widgets pq utilizare archivos de destino
    HomeView(),
    PopularView(),
    FavouriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: pageIndex,// de donde vusca el valor
        children: viewRoutes,
      ),
//      ----> Boton de Navegación inferior<---      \
      bottomNavigationBar:  CustomButtonNavigatobar(
        currentIndex: pageIndex,
      ),
    );
  }
}
