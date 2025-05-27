import 'package:practica_final/models/model_games.dart';

class FavoritesManager {
  static final List<Driver> _favorites = [];

  static List<Driver> get favorites => _favorites;

  static void add(Driver driver) {
    if (!_favorites.any((d) => d.id == driver.id)) {
      _favorites.add(driver);
    }
  }

  static void remove(Driver driver) {
    _favorites.removeWhere((d) => d.id == driver.id);
  }

  static bool isFavorite(Driver driver) {
    return _favorites.any((d) => d.id == driver.id);
  }
}
