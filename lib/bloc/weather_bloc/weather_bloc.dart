import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_events.dart';
import 'package:weather_app/bloc/weather_bloc/weather_repository.dart';
import 'package:weather_app/bloc/weather_bloc/weather_states.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  final WeatherRepository repository = WeatherRepository();
  WeatherBloc(WeatherState initialState) : super(initialState);

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event) async* {
      if(event is FetchCurrentEvent) yield* _fetchCurrentAndForecast(event);
  }

  Stream<WeatherState> _fetchCurrentAndForecast(FetchCurrentEvent event) async* {
    try {
      yield FetchCurrentSuccess(
        await repository.fetchCurrentAndForecast(event)
      );
    } catch (e) {
      print('ERROR IN BLOC FETCH CURRENT AND FORECAST');
      yield WeatherFailureState();
    }
  }

  
}