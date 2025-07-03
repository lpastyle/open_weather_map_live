
import 'package:flutter/material.dart';
import 'package:open_weather_map_live/weather_api_response.dart';
import 'package:open_weather_map_live/weather_api_service.dart';

class CurrentWeatherView extends StatelessWidget {
  final Forecast forecast;

  const CurrentWeatherView({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 4,
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 7,
        child: Container (
          padding: const EdgeInsets.all(8),
          color: Colors.lightBlueAccent,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(WeatherApiService.iconUrlFromId(forecast.weather.first.icon)),
                  Text("${forecast.main.temp.toInt()}°C", style: const TextStyle(fontSize: 26))
                ],
              ),
              const Spacer(),
              Text(forecast.weather.first.description, style: const TextStyle(fontSize: 24)),
              Text("Min:${forecast.main.tempMin.toInt()}°C - Max:${forecast.main.tempMax.toInt()}", style: const TextStyle(fontSize: 22)),
            ],
          ),
        ),

      ),

    );
  }

}