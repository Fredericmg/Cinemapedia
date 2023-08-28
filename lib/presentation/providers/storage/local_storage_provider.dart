import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ----> Creación de un Provider Simple <---- \/
// --> Que extienda del repositorio de Implementaciones <-- \/
//esto extendera del repositorio de implementaciones de Isar
// el valor null lo modificamo por una funcion con cuerpo (){}
final localStorageRepositoryProvider = Provider((ref) {
// devuelve el Repositorio de implentaciones con
// valor de isardatasource del repositorio en vacio()
  return LocalStorageRepositoryImpl(IsarDatasource('directory', 'name'));
});
