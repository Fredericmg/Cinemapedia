import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomButtonNavigatobar extends StatelessWidget {
//      --> Metodo para utilizarlo como acción <--      \
// Al ser las rutas por numero lo haremos int
  final int currentIndex;

  const CustomButtonNavigatobar({super.key, required this.currentIndex});

//      --> Creamos la funcion  ( el articulo tocado ) <--      \
// Reciviremos un buildContes de contexto y un numero del indice
// que sera la ruta pero esta lo haremos con la accion: switch
  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      // utilizamos index pq es una acción del IndexStack
      case 0: // si el pulsado es el 0
        context.go('/home/0'); // ir al 0
        break;
      case 1: // si el pulsado es el 1
        context.go('/home/1'); // ir al 1
        break;
      case 2: // si el pulsado es el 2
        context.go('/home/2'); // ir al 2
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
//      --> Usamos el nuevo metodo creado <--      \
        currentIndex:
            currentIndex, // lo llamaremos igual (es mas facil identificar)
// usaremos la función onItemTapped
// el index sera igual a la String del ontap (ss)
        onTap: (value) => onItemTapped(context, value),
        elevation: 0, // esto borra la linea de separación
        items: const [
          BottomNavigationBarItem(label: 'Inicio', icon: Icon(Icons.home_max)),
          BottomNavigationBarItem(
              label: 'Categorias', icon: Icon(Icons.label_outline)),
          BottomNavigationBarItem(
              label: 'Favoritos', icon: Icon(Icons.favorite_outline)),
        ]);
  }
}
