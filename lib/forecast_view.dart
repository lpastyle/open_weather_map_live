import 'package:flutter/material.dart';
import 'package:open_weather_map_live/current_weather_view.dart';
import 'package:open_weather_map_live/daily_weather_tile.dart';
import 'package:open_weather_map_live/grouped_weather.dart';
import 'package:open_weather_map_live/weather_api_response.dart';
import 'package:open_weather_map_live/weather_api_service.dart';

class ForecastView extends StatelessWidget {
  final WeatherApiResponse? apiResponse;

  // Ctor
  const ForecastView({super.key, required this.apiResponse});

  @override
  Widget build(BuildContext context) {
    if (apiResponse == null) {
      return const Center(
        child: Text("Pas de données", style: TextStyle(fontSize: 24))
      );
    } else {
      List<GroupedWeather> weatherByDay = WeatherApiService.groupByDay(apiResponse!);
      return Column(
        children: [
          CurrentWeatherView(
            forecast: apiResponse!.list.first,
            cityName: apiResponse!.city.name,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => DailyWeatherTile(day: weatherByDay[index]),
              separatorBuilder:(context, index) => const Divider(),
              itemCount: weatherByDay.length,
            )
          )
        ],
      );
    }
  }
}