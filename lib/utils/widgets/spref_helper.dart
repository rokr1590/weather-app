import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/location_model.dart';

class SharedPreferencesHelper {
  static const String favoriteKey = 'favoriteLocations';

  static Future<void> saveFavoriteLocations(List<LocationModel> locations) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> encodedLocations = locations.map((loc) => json.encode(loc.toJson())).toList();
    print(encodedLocations);
    prefs.setStringList(favoriteKey, encodedLocations);
  }

  static Future<List<LocationModel>> getFavoriteLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? encodedLocations = prefs.getStringList(favoriteKey);
    if (encodedLocations != null) {
      return encodedLocations.map((encodedLoc) => LocationModel.fromJson(json.decode(encodedLoc))).toList();
    } else {
      return [];
    }
  }


}