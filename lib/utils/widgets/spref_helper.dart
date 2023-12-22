import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/location_model.dart';

class SharedPreferencesHelper {
  static const String favoriteKey = 'favoriteLocations';

  static Future<void> saveFavoriteLocations(List<LocationModel> locations) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> encodedLocations = locations.map((loc) => json.encode(loc.toJson())).toList();
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

  static Future<void> toggleFavoriteLocation(LocationModel location) async {
    final prefs = await SharedPreferences.getInstance();
    List<LocationModel> favorites = await getFavoriteLocations();

    if (favorites.any((fav) => fav.name == location.name)) {
      // Remove from favorites
      favorites.removeWhere((fav) => fav.name == location.name);
      print("Removing from favourites");
    } else {
      print("Adding to favourites");
      // Add to favorites
      favorites.add(location);
    }
    favorites.forEach((element) { 
      print(element.name);
    });
    final List<String> encodedFavorites = favorites.map((fav) => json.encode(fav.toJson())).toList();
    prefs.setStringList(favoriteKey, encodedFavorites);
  }

  static Future<void> removeLocation(LocationModel location) async {
     final prefs = await SharedPreferences.getInstance();
     List<LocationModel> favorites = await getFavoriteLocations();
     if(favorites.any((fav) => fav.name == location.name)) {
      favorites.removeWhere((fav) => fav.name == location.name);
      print("Found Location");
     }
     print("Removing Location");
     final List<String> encodedFavorites = favorites.map((fav) => json.encode(fav.toJson())).toList();
     prefs.setStringList(favoriteKey, encodedFavorites);
  }

  static Future<void> addLocation(LocationModel location) async {
     final prefs = await SharedPreferences.getInstance();
     List<LocationModel> favorites = await getFavoriteLocations();
     if(favorites.any((fav) => fav.name != location.name)) {
      favorites.add(location);
      print("No Location Found");
     }
     print("Adding Location");
     final List<String> encodedFavorites = favorites.map((fav) => json.encode(fav.toJson())).toList();
     prefs.setStringList(favoriteKey, encodedFavorites);
  }


}