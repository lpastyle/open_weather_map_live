import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:open_weather_map_live/api_key_service.dart';
import 'package:open_weather_map_live/geo_position.dart';
import 'package:http/http.dart';
import 'package:open_weather_map_live/grouped_weather.dart';
import 'package:open_weather_map_live/weather_api_response.dart';

class WeatherApiService {
  final baseUrl="https://api.openweathermap.org/data/2.5/forecast";
  final lat = "lat=";
  final lon = "lon=";
  final appid = "appid=";
  final lang = "lang=fr";
  final units = "units=metric";

static List<String> daysOfWeek = ["","Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];

static List<GroupedWeather> groupByDay(WeatherApiResponse apiResponse) {
    List<GroupedWeather> daily = [];
    for (var forecast in apiResponse.list) {
      var date = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
      var dayName = daysOfWeek[date.weekday];
      var hour = date.hour;
      debugPrint("datetime = $hour");
      var min = forecast.main.tempMin.toInt();
      var max = forecast.main.tempMax.toInt();
      var description = forecast.weather.first.description;
      var iconId = forecast.weather.first.icon;
      final index = daily.indexWhere((d) => d.day == dayName);
      // tester si le jour a déja été traité
      if (index == -1) {
        daily.add(GroupedWeather(min, max, description, iconId, dayName));
      } else {
        // Ne garder la température extrémum
        if (daily[index].min > min) daily[index].min = min;
        if (daily[index].max < max) daily[index].max = max;
        // Ne garder que les description en milieu de journée
        if (hour >= 11 && hour <= 14) {
          daily[index].description = description;
          daily[index].icon = iconId;
        }
      }
    }
    return daily;
  }

static String iconUrlFromId(String iconId) {
    String url = "http://openweathermap.org/img/wn/$iconId@2x.png";
    debugPrint("iconUrl=$url");
    return url;
  }

String prepareQuery(GeoPosition geoPosition) {
  final userLat = geoPosition.lat;
  final userLon = geoPosition.lon;
  final query = "$baseUrl?$lat$userLat&$lon$userLon&$units&$lang&$appid$apiKey";
  debugPrint("http query = $query");
  return query;
 }

 Future<WeatherApiResponse> callWeatherApi(GeoPosition position) async {
  final query = prepareQuery(position);
  final uri = Uri.parse(query);
  final call = await get(uri);

  // le 'dynamic' permet d'avoir un polymorphisme de type
  Map<String, dynamic> jsonResponse = json.decode(call.body);
  //debugPrint(jsonResponse.toString());
  return WeatherApiResponse.fromJson(jsonResponse);
 }

}