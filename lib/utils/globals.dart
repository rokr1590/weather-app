import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_states.dart';

bool isShowingPopup = false;
bool appInBackground = false;
WeatherBloc weatherBloc = WeatherBloc(LoadingWeatherState());