import 'package:weather_app/bloc/weather_bloc/weather_client.dart';
import 'package:weather_app/bloc/weather_bloc/weather_events.dart';
import 'package:weather_app/models/weather_response_model.dart';

class WeatherRepository {
  final WeatherClient client = WeatherClient();

  Future<ForecastResponseModel> fetchCurrentAndForecast(FetchCurrentEvent event) async {
    return await client.fetchCurrentAndForecast(event);
  }
}