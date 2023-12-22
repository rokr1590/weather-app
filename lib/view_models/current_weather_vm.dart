import 'package:flutter/cupertino.dart';
import 'package:weather_app/bloc/weather_bloc/weather_events.dart';
import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/models/weather_response_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/utils/globals.dart';
import 'package:weather_app/utils/widgets/spref_helper.dart';


class CurrentWeatherViewModel extends ChangeNotifier {

  bool isLoading = false;

  bool _isFavourite = false;

  bool get isFavourite => _isFavourite; 

  List<Daily>? _weekForecast;

  List<Daily>? get weekForecast => _weekForecast;

  Position? _position ;

  Position? get position => _position;

  String? _city ;

  String? get city => _city;


  void toggleLoading({required bool value}){
    isLoading = value;
    notifyListeners();
  }

  void setWeekForecast({required List<Daily> weekForecast}){
    _weekForecast = weekForecast;
    notifyListeners();
  }

  Future<String> getCurrentPostion() async {

    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    //fetch the current Location
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    
    //set position value 
    _position = currentPosition;
    weatherBloc.add(FetchCurrentEvent(7, _position!.latitude.toString(), _position!.longitude.toString()));
    

    //convert the location into a list of placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
    print(placemarks);
    //get city name from placemark list
    String? cityFound = placemarks[1].locality;

    print("The Current city is ${cityFound}");
    _city = cityFound;
    notifyListeners();

    return cityFound ?? "";
  }

  void toggleFavourite({required bool value}) async{
    _isFavourite = value;
    if(_isFavourite == true)
    {LocationModel location = LocationModel(latitude: _position!.latitude, longitude: _position!.longitude,name: _city);
    await SharedPreferencesHelper.saveFavoriteLocations([location]);
    }
    notifyListeners();

  }
}