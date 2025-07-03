import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:open_weather_map_live/add_city_view.dart';
import 'package:open_weather_map_live/data_persistence.dart';
import 'package:open_weather_map_live/drawer_menu.dart';
import 'package:open_weather_map_live/forecast_view.dart';
import 'package:open_weather_map_live/geo_position.dart';
import 'package:open_weather_map_live/location_service.dart';
import 'package:open_weather_map_live/weather_api_response.dart';
import 'package:open_weather_map_live/weather_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  //LocationData? locationData;
  GeoPosition? userPosition;
  WeatherApiResponse? apiResponse;
  // villes visibles dans le drawer menu
  List<String> cities = [];
  
  @override
  void initState() {
    //getUserLocation();
    getUserPosition();
    updateCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        titleTextStyle: TextStyle(fontSize: 24, color: Colors.white),
        title: Text("Open Weather Map")
      ),
      drawer: DrawerMenu(
        //cities: [userPosition == null ? "" : userPosition!.city, "Paris", "Madrid", "Tunis"],
        cities: cities,
        onTap: onMenuItemTap
      ),
      body: Column(
        children: [
          AddCityView(onAddCity: onAddCity),
          Expanded(
              child: ForecastView(apiResponse: apiResponse)
          )
        ]
      )      
      );
  }

  // void getUserLocation() async {
  //   final currentLocation = await LocationService().getPosition();
  //   setState(() => locationData = currentLocation);
  // }

  void getUserPosition() async {
    final currentPosition = await LocationService().getCity();
    setState(() {
      userPosition = currentPosition;
      WeatherApiService().callWeatherApi(userPosition!);
    } );
    final currentResponse = await WeatherApiService().callWeatherApi(userPosition!);
    setState(() {
      apiResponse = currentResponse;
    });
    // add user city in city list
    onAddCity(currentResponse.city.name);
  }

  void onMenuItemTap(String s) {
    debugPrint("ontap($s)");
    Navigator.of(context).pop();
  }

  void onAddCity(String s) {
    debugPrint("add city <$s>");
    DataPersistence().addCity(s).then((value) => updateCities());
  }

  // Charger les villes sauvegardées dans les shared preferences
  void updateCities() async {
    cities = await DataPersistence().getCities();
    setState(() {});
  }
}