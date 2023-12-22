import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/weather_bloc/weather_events.dart';
import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/models/weather_response_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/service/api_client.dart';
import 'package:weather_app/utils/globals.dart';
import 'package:weather_app/utils/widgets/spref_helper.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';


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

  List<dynamic>? _predictions = [];

  List<dynamic>? get predictions => _predictions;

  String sessionToken = "";

  Uuid uuid = Uuid();

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

    if(cityFound == null)

    print("The Current city is ${cityFound}");
    _city = cityFound;
    notifyListeners();

    return cityFound ?? "";
  }

  void toggleFavourite({required bool value,LocationModel? locationToRemove}) async{
    _isFavourite = value;
    notifyListeners();
    await SharedPreferencesHelper.toggleFavoriteLocation(locationToRemove!);
    // List<LocationModel> retrievedLocations = await SharedPreferencesHelper.getFavoriteLocations();
    
    // retrievedLocations.forEach((element) {
    //     print(element.name);
    //  });
    // if(_isFavourite == true)
    // {
    //   LocationModel location = LocationModel(latitude: _position!.latitude, longitude: _position!.longitude,name: _city);
    //   //await SharedPreferencesHelper.saveFavoriteLocations([location]);

    //   var alreadyPresent = retrievedLocations.firstWhere((element) => element.name==_city,orElse: null);
    //   if(alreadyPresent != null){
    //     retrievedLocations.add(location);
    //     await SharedPreferencesHelper.saveFavoriteLocations(retrievedLocations);
    //   }
    // }
    // else if(_isFavourite = false) {
    //   retrievedLocations.removeWhere((element) => element.name == locationToRemove!.name);
    // }
    // notifyListeners();
  }

  void getSuggestions(String input) async {
    String googleAPiKey = Apis.GOOGLE_MAP_API_KEY;
    String searchUrl = Apis.GOOGLE_MAPS_PLACE_AUTO;
    String request = "$searchUrl?input=$input&key=$googleAPiKey&sessiontoken=$sessionToken";
    if(sessionToken.isEmpty){
      sessionToken = uuid.v4();
    }
    var response = await http.get(Uri.parse(request));
    if(response.statusCode == 200 || response.statusCode == 201){
        _predictions = jsonDecode(response.body.toString())['predictions'];
        notifyListeners();
    }
  }

  Future<void> showWeatherLatLng(String placeId,String cityFound) async{
    toggleLoading(value: true);
    String googleAPiKey = Apis.GOOGLE_MAP_API_KEY;
    String searchUrl = Apis.GOOGLE_MAPS_PLACE_DETAIL;
    String request = "$searchUrl?place_id=$placeId&key=$googleAPiKey&sessiontoken=$sessionToken";
    final response = await http.get(Uri.parse(request));
    if(response.statusCode == 200 || response.statusCode == 201){
      double lat=jsonDecode(response.body.toString())['result']['geometry']['location']['lat'];  
      double long=jsonDecode(response.body.toString())['result']['geometry']['location']['lng'];
      _position = Position(longitude: long, latitude: lat, timestamp: _position!.timestamp, accuracy: _position!.accuracy, altitude: _position!.altitude, altitudeAccuracy: _position!.altitudeAccuracy, heading: _position!.heading, headingAccuracy: _position!.headingAccuracy, speed: _position!.speed, speedAccuracy: _position!.speedAccuracy);
    }
    weatherBloc.add(FetchCurrentEvent(7, _position!.latitude.toString(), _position!.longitude.toString()));
    

    //convert the location into a list of placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(_position!.latitude, _position!.longitude);
    //get city name from placemark list
    isLoading = false;
    _city = cityFound;
    notifyListeners();
  }

  Future<void> initializeUsingLatLng(double latitude,double longitude) async {
    toggleLoading(value: true);
    weatherBloc.add(FetchCurrentEvent(7, _position!.latitude.toString(), _position!.longitude.toString()));
    

    //convert the location into a list of placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(_position!.latitude, _position!.longitude);
    //get city name from placemark list
    String? cityFound = placemarks[0].locality;
    isLoading = false;
    _city = cityFound;
    notifyListeners();
  }

  void restToDefault(){
    _isFavourite = false;
    notifyListeners();
  }
}