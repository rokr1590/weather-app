import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_response_model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class FetchCurrentSuccess extends WeatherState {
  final ForecastResponseModel response;
  const FetchCurrentSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class LoadingWeatherState extends WeatherState {}

class WeatherFailureState extends WeatherState {}
