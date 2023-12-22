import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_events.dart';
import 'package:weather_app/bloc/weather_bloc/weather_states.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/globals.dart';
import 'package:weather_app/utils/images.dart';
import 'package:weather_app/utils/toast.dart';
import 'package:weather_app/view_models/current_weather_vm.dart';

class CurrentWeatherView extends StatefulWidget {
  const CurrentWeatherView({super.key});

  @override
  State<CurrentWeatherView> createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {

  late CurrentWeatherViewModel currentWeatherViewModel;
  late Size screenSize;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    currentWeatherViewModel = Provider.of<CurrentWeatherViewModel>(context,listen: false);
    currentWeatherViewModel.getCurrentPostion();
    
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CustomColor.darkGrey,
                CustomColor.lightGrey
              ]
            )
          ),
          child: BlocListener<WeatherBloc,WeatherState>(
            bloc: weatherBloc,
            listener: (context,state){
              if(state is FetchCurrentSuccess){
                if(state.response.daily != null && state.response.daily!.isNotEmpty){
                  currentWeatherViewModel.setWeekForecast(weekForecast: state.response.daily!);
                }
                else {
                  showToast("Something went wrong!!", ToastType.error, screenSize, context);
                }
                //print("Called Current Weather");
              }
            },
            child: Consumer<CurrentWeatherViewModel>(
                builder: (context, value, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    //value.weekForecast != null ?
                    [
                      //Place Icon
                      Icon(
                        Icons.place_rounded,
                        size: screenSize.height * 0.032,
                      ),

                      SizedBox(
                        height: screenSize.height*0.016,
                      ),

                      //City name
                      Text(
                        value.city ?? "Loading City...",
                        style: GoogleFonts.bebasNeue(
                          fontSize : screenSize.height * 0.04
                        ),
                      ),
                      
                      //Lottie Animations
                      Lottie.asset(
                        getWeatherAnimation(value.weekForecast !=null && value.weekForecast![0].weather != null?value.weekForecast![0].weather![0].main:null)
                      ),

                      //temperature
                      value.weekForecast == null || value.weekForecast!.isEmpty || value.weekForecast![0].temp == null ?
                      SizedBox(
                        height: screenSize.height * 0.05,
                        width: screenSize.width * 0.1,
                        child: const CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 4,
                        ),
                      ) :
                      Text(
                        value.weekForecast!=null?"${value.weekForecast![0].temp!.day!.round()}°C" : "Loading Temperature ..",
                        style: GoogleFonts.bebasNeue(
                          fontSize : screenSize.height * 0.06
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height*0.032,
                      ),
                      Container(
                        padding : EdgeInsets.symmetric(vertical: screenSize.height * 0.016),
                        height : screenSize.height * 0.25,
                        width : double.infinity,
                        child: ListView.builder(
                          scrollDirection : Axis.horizontal,
                          itemCount: value.weekForecast!.length-1,
                          itemBuilder: (BuildContext context, int index) { 
                            return Container(
                              padding: EdgeInsets.all(screenSize.height * 0.016),
                              width: screenSize.width * 0.3,
                              margin : EdgeInsets.symmetric(horizontal : screenSize.width * 0.026),
                              decoration: BoxDecoration(
                                color : index ==0 ? CustomColor.mediumDarkGrey:Colors.black,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 2,
                                  color: index ==0 ?Colors.black :Colors.white
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getFormattedWeekday(value.weekForecast![index].dt!).substring(0,3),
                                    style: GoogleFonts.bebasNeue(
                                      fontSize: screenSize.height * 0.020,
                                      color: index ==0 ?Colors.black :Colors.white,
                                      fontWeight: FontWeight.w500
                                    ), 
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.008,
                                  ),
                                  Text(
                                    formatUnixTimestamp(value.weekForecast![index].dt!),
                                    style: GoogleFonts.bebasNeue(
                                      fontSize: screenSize.height * 0.020,
                                      color: index ==0 ?Colors.black :Colors.white,
                                      fontWeight: FontWeight.w500
                                    ),
                                    overflow: TextOverflow.ellipsis, 
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.016,
                                  ),
                                  Lottie.asset(
                                    getWeatherAnimation(value.weekForecast !=null && value.weekForecast![index].weather != null?value.weekForecast![index].weather![0].main:null,),
                                    height: screenSize.height * 0.07,
                                    width: screenSize.width * 0.17
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.016,
                                  ),
                                  Text(
                                    value.weekForecast![index].temp != null
                                        ? "${value.weekForecast![index].temp!.day!.round()}°C"
                                        : "Loading Temperature ..",
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: screenSize.height * 0.025,
                                        color: index ==0 ?Colors.black :Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            );
                           },
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.016,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.032),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                currentWeatherViewModel.toggleFavourite(value: !value.isFavourite);
                              },
                              child: value.isFavourite ?
                              Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                              ) :
                              Icon(
                                Icons.favorite_border_outlined,
                              ),
                            )
                          ],
                        ),
                      ),

                    ] 
                    // :[ 
                    //   SizedBox(
                    //     height: screenSize.height * 0.1,
                    //     width: screenSize.width * 0.2,
                    //     child: const CircularProgressIndicator(
                    //       color: Colors.black,
                    //       strokeWidth: 4,
                    //     )
                    //   )
                    // ],
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  String getFormattedWeekday(int unixTimestamp) {
    // Convert Unix timestamp to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000, isUtc: true);

    // Format the date to display the weekday
    return DateFormat('EEEE').format(dateTime);
  }

  String formatUnixTimestamp(int unixTimestamp) {
  // Convert Unix timestamp to DateTime
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000, isUtc: true);
  // Format the date
  String formattedDate = DateFormat('dd MMM').format(dateTime);
  return formattedDate;
}

  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return CustomAnimations.clear;
    switch (mainCondition.toLowerCase()) {
      case 'clouds' :
      case 'mist' :
      case 'smoke' :
      case 'haze' :
      case 'dust' :
      case 'fog' :
        return CustomAnimations.overcast;
      case 'rain' :
      case 'drizzle' :
      case 'shower rain' :
        return CustomAnimations.rain;
      case 'thunderstorm' :
        return CustomAnimations.thunderstorm;
      case 'clear':
        return CustomAnimations.clear;
      default :
        return CustomAnimations.sunny;
    }
  }
}