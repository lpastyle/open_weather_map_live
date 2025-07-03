import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        titleTextStyle: TextStyle(fontSize: 24, color: Colors.white),
        title: Text("Open Weather Map")
      ),
      body: Center(
        child: Text("HOME PAGE"),)
    );
    
  }

}