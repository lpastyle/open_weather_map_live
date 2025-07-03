import 'package:flutter/material.dart';
import 'package:location/location.dart';
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
  
  @override
  void initState() {
   //getUserLocation();
   getUserPosition();
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
      body: Center(
          //child: Text('Latitude=${locationData?.latitude}\nLongitude=${locationData?.longitude}',
          //child: Text('Latitude=${userPosition?.lat}\nLongitude=${userPosition?.lon}\nCity=${userPosition?.city}',
          //child: Text("Api count=${apiResponse?.cnt}\nLatitude=${userPosition?.lat}\nLongitude=${userPosition?.lon}\nCity=${userPosition?.city}",
          //style: TextStyle(fontSize: 24)
          child: ForecastView(apiResponse:  apiResponse),
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
  }
}