import 'package:flutter/material.dart';
import 'package:open_weather_map_live/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Weather Live',
      theme: ThemeData(
        useMaterial3: true 
      ),
      home: HomePage()
    );
  }
}
