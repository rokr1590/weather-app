import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCurrentEvent extends WeatherEvent{
  final int days;
  final String latitude;
  final String longitude;

  FetchCurrentEvent(this.days,this.latitude,this.longitude);

   @override
  String toString() => "FetchCurrentAndForecast { FetchCurrentAndForecast: ${days.toString()}}";

  @override
  List<Object> get props => [int];
}