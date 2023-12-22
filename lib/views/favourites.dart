import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/widgets/spref_helper.dart';
import 'package:weather_app/view_models/current_weather_vm.dart';
import 'package:weather_app/view_models/favorite_vm.dart';
import 'package:weather_app/views/current_weather.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late Size screenSize;
  List<LocationModel> listOfFav = [];
  late FavoriteViewModel favoriteViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteViewModel =
        Provider.of<FavoriteViewModel>(context, listen: false);
    favoriteViewModel.fetchFavList();
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
                  colors: [CustomColor.darkGrey, CustomColor.lightGrey])),
          child: Consumer<FavoriteViewModel>(
            builder: (context, value , child) {
              return 
              value.favList != null ?
              value.favList!.isEmpty ?
              Center(
                child: Container(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.4,
                  child: Text(
                    "No Favorites Yet!",
                    style: GoogleFonts.bebasNeue(
                      fontSize: screenSize.height * 0.1,
                      color : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              :
              ListView.builder(
                itemCount: value.favList!.length,
                itemBuilder:(context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context)=>CurrentWeatherView(
                            latitude: value.favList![index].latitude,
                            longitude: value.favList![index].longitude,
                            back: true,
                          )));},
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.016,
                        vertical: screenSize.width * 0.032
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.016,
                        vertical: screenSize.width * 0.032
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_rounded,color: Colors.white,),
                          SizedBox(width: screenSize.width * 0.016,),
                          Text(
                            value.favList![index].name!,
                            style: GoogleFonts.bebasNeue(
                              fontSize : screenSize.height * 0.05,
                              color : Colors.white,
                              fontWeight : FontWeight.w400
                            )
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              removeFavourite(value.favList![index]);
                              favoriteViewModel.fetchFavList();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.2,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        strokeWidth: 4,
                      ),
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }


  void setFavourite(LocationModel location) async {
    await SharedPreferencesHelper.addLocation(location);
  }

  void removeFavourite(LocationModel location) async {
    await SharedPreferencesHelper.removeLocation(location);
  }
}