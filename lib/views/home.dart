import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/globals.dart';
import 'package:weather_app/utils/widgets/dialog.dart';
import 'package:weather_app/view_models/home_vm.dart';
import 'package:weather_app/views/profile.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => new HomeViewState();
}

class HomeViewState extends State<HomeView> with WidgetsBindingObserver{
  
  late Size screenSize;
  int pageIndex = 0;
  int selectedIndex = 3;
  GlobalKey internetModalKey = GlobalKey();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final HomeViewModel homeViewModel = HomeViewModel(); 

  final pages = [
    const ProfileView(),
    const ProfileView(),
    const ProfileView(),
    const ProfileView()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkInternetAvailability();
  }

  /// Checks if internet connection is enabled. If not, throws up a dialog that highlights
  /// that the connection is not available.
  void checkInternetAvailability() async {
    bool? isConnected;
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
        if (isShowingPopup == false && appInBackground == false) {
          showDialog(
            context: context,
            builder: (ctx) {
              return ConfirmationDialog(
                key: internetModalKey,
                acceptAction: () {
                  if (isConnected == true) {
                   
                    Navigator.pop(context);
                  }
                },
                denyAction: () {},
                header: 'Error',
                content: 'Please check your Internet connection and try again.',
                denyButtonText: '',
                acceptButtonText: '',
                dialogType: 0,
              );
            },
          );
        }
      } else if (result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        
        if (internetModalKey.currentContext != null) {
          Navigator.pop(internetModalKey.currentContext!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: screenSize.height * 0.08,
          child: BottomNavigationBar(
            iconSize: screenSize.height * 0.026,
            selectedFontSize: screenSize.height * 0.014,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            unselectedFontSize: 14,
            backgroundColor: Colors.white,
            currentIndex: selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.shifting,
            onTap: (int index){
              setState(() {
                selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.today_outlined,
                    size: 25,
                    color: CustomColor.darkGrey,
                  ),
                  label: "Today's Weather",
                  icon: Icon(
                    Icons.today_outlined,
                    size: 25,
                    color: CustomColor.lightGrey,
                  )
              ),
              BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.location_on_outlined,
                    size: 25,
                    color: CustomColor.darkGrey,
                  ),
                  label: "Location",
                  icon: Icon(
                    Icons.location_on_outlined,
                    size: 25,
                    color: CustomColor.lightGrey,
                  )
              ),
              BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.favorite_border_outlined,
                    size: 25,
                    color: CustomColor.darkGrey,
                  ),
                  label: "Favourites",
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    size: 25,
                    color: CustomColor.lightGrey,
                  )
              ),
              BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person_outline_outlined,
                    size: 25,
                    color: CustomColor.darkGrey,
                  ),
                  label: "Profile",
                  icon: Icon(
                    Icons.person_outline_outlined,
                    size: 25,
                    color: CustomColor.lightGrey,
                  )
              )
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: showExitPopup,
          child: pages[selectedIndex],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            acceptAction: () {
              Navigator.of(context).pop(true);
            },
            denyAction: () {
              Navigator.of(context).pop(false);
            },
            header: 'Confirm Action',
            content: 'Are you sure you want to exit Sobot?',
            denyButtonText: 'No',
            acceptButtonText: 'Yes',
            dialogType: 1,
          ),
        ) ??
    false;
  }

  
}