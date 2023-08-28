import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

// Este repositorio es inmutable
// Funcionalidad boleana
// lo definiremos <bool>
final initialLoadingProvider = Provider<bool>((ref) {
// Provider que queremos que cargen antes de mostrarse
// clocaremos un .isEmpty porque solo se usara cuando este cargando
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

// si el step 1 esta cargando que debuelva true
// Creamos la condicion
  // if (step1) return true;
  // if (step2) return true;
  // if (step3) return true;
  // if (step4) return true;
// Esta es mas facil de hacerla unicament en 1 linea y es lo mismo
// los añades todos
  if (step1 || step2 || step3 || step4) return true;

  return false; // terminamos de cargar
// Al terminar de cargar devolvera un false
});
