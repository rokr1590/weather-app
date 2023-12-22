import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:weather_app/bloc/weather_bloc/weather_events.dart';
import 'package:weather_app/models/weather_response_model.dart';
import 'package:weather_app/service/api_client.dart';

class WeatherClient {

  Future<ForecastResponseModel> fetchCurrentAndForecast(FetchCurrentEvent event) async {
    HttpResponse response;
    var query;
    try{
      query = "&lon=${event.longitude}&lat=${event.latitude}&exclude=current,hourly,minutely,alerts&units=metric";
      response = await getApi().fetchCurrentAndForecast(query);
      if(response.response.statusCode == 200){
        print("Fetched Weather Request Succesfully");
        ForecastResponseModel forecastResponseModel = ForecastResponseModel();
        try{
          forecastResponseModel = ForecastResponseModel.fromJson(response.response.data);
        } catch (e) {
          print("Error in parsing json of Weather Response ${e}");
          return ForecastResponseModel(error: "Error in parsing json");
        }
        return forecastResponseModel; 
      }
      else {
        return ForecastResponseModel(error: "Request Unsuccessful for fetching Weather Data");
      }
    } catch (error) {
      if(error is DioError) {
        if(error.response != null){
          if(error.response!.statusCode == 401) {
            return ForecastResponseModel(error: "401 Error in Response DioError");
          }
          return ForecastResponseModel(error: "Something Went wrong DioError");
        }
      }
      return ForecastResponseModel();
    }

  }
}