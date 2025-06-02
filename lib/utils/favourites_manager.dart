import 'package:practica_final/models/model_games.dart';

class FavoritesManager {
  static final List<Driver> _favorites = [];

  static List<Driver> get favorites => _favorites; //acceso a la lista

  static void add(Driver driver) { //añadir un piloto a la lista
    if (!_favorites.any((d) => d.id == driver.id)) {
      _favorites.add(driver);
    }
  }

  static void remove(Driver driver) { //quitar de la lista
    _favorites.removeWhere((d) => d.id == driver.id);
  }

  static bool isFavorite(Driver driver) { //comptobar si esta en la lista para poder añadirlo o eliminarlo de ella
    return _favorites.any((d) => d.id == driver.id);
  }
}
/*
es una lista privada y estatica que guarda todos los pilotos favoritos
solo se puede reasignar ya que es final y no es necesario instanciar la clase
porque es estatica
*/