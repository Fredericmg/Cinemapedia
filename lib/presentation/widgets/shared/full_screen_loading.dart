import 'package:flutter/material.dart';

class FullScreenLoadint extends StatelessWidget {
  const FullScreenLoadint({super.key});

// Debemos crearnos un Stream para utilizarlo en la accion
// stream:
// Sera un Stream de Strings con una funcion ();
  Stream<String> getLoadingtString() {
// Arreglo de Stings
// Creacion de la lista de Strings
    final mensajes = <String>[
      'Espera',
      'Ya va',
      'Falta Poco',
      'Enbreve',
      'No te enfades que voy',
      'Ya esta',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (steps) {
// Estos pasos queremos que returns los String con el indice de steps
      return mensajes[steps];
    }).take(mensajes.length); // cancelacion del periodico
  }

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Cargando Películas'),
        const SizedBox(
          height: 10,
        ),
        const CircularProgressIndicator(
          strokeWidth: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: getLoadingtString(),
          builder: (context, snapshot) {
// Creamos una condicion si no tiene data colocacion ! delante
            if (!snapshot.hasData) return const Text('Cargando ...');
// De lo contrario que devuelva la data
            return Text(snapshot.data!);
          },
        )
      ],
    ));
  }
}
