import 'package:intl/intl.dart';

// Creamos una clase
class HumanFormat {
  static String humanReadNumber(double number, [int decimal = 0]) {
// En la funcion crearemos un metodo
    final formatNumero = NumberFormat.compactCurrency(
// que quieres que haga este metodo
// aqui igualamso el decimaDigits a la lista creada
      decimalDigits: decimal,
      symbol: '',
// Nombre definicion total numero 
// (Ej. español = miles en ingles'en' = K)
      locale: 'en',
    ).format(number);
// Queremos que devuelva el formatNumero
    return formatNumero;
  }
}
