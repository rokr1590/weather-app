import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/utils/widgets/spref_helper.dart';

class FavoriteViewModel extends ChangeNotifier{

  List<LocationModel>? favList = [];

  void fetchFavList() async { 
    favList = await SharedPreferencesHelper.getFavoriteLocations();
    notifyListeners(); 
  }

}