import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final List<String> cities;
  
  final Function(String) onTap;

  const DrawerMenu({super.key, 
    required this.cities,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          menuHeader(),
          Expanded(
            child : ListView.builder(
              itemBuilder: ((context, index) => menuItem(cities[index])),
              itemCount: cities.length
            ),
          ),
        ],
      )
    );
  }

  DrawerHeader menuHeader() {
    return const DrawerHeader(
        child: Column(
          children: [
            Icon(Icons.location_on_outlined, size: 40, color: Colors.pinkAccent),
            Text("Mes Villes", style: TextStyle(fontSize: 32))
          ],
        )
    );
  }

  ListTile menuItem(String string) {
    return ListTile(
        title: Text(
          string,
          style: const TextStyle(fontSize: 30)
        ),
        onTap: (() => onTap(string)),
    );
  }
}