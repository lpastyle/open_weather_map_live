import 'package:flutter/material.dart';
import 'package:open_weather_map_live/current_weather_view.dart';
import 'package:open_weather_map_live/weather_api_response.dart';

class ForecastView extends StatelessWidget {
  final WeatherApiResponse? apiResponse;

  // Ctor
  const ForecastView({super.key, required this.apiResponse});

  @override
  Widget build(BuildContext context) {
    return (apiResponse == null) 
    ? const Center(child: Text("Pas de données", style: TextStyle(fontSize: 24)))
    :  Column(  
      children: [ 
        CurrentWeatherView(forecast: apiResponse!.list.first)
      ],
    );
  }}