import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/src/features/search/data/cities_db.dart';
import 'package:weather_app/src/features/search/domain/city_model.dart';

class CitySearchNotifier extends StateNotifier<List<City>> {
  final CitiesDatabase _citiesDatabase;

  CitySearchNotifier(this._citiesDatabase) : super([]);

  Future<void> searchCities(String query) async {
    if (query.isNotEmpty) {
      // Fetch results from the CitiesDatabase
      final results = await _citiesDatabase.searchCities(query);
      state = results; // Update state with the list of City objects
    } else {
      state = []; // Clear results if query is empty
    }
  }
}

// Provider to access the CitySearchNotifier
final citySearchProvider =
    StateNotifierProvider<CitySearchNotifier, List<City>>((ref) {
  return CitySearchNotifier(CitiesDatabase());
});
