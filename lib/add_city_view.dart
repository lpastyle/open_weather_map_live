import 'package:flutter/material.dart';

class AddCityView extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final Function(String) onAddCity;

  AddCityView({super.key, required this.onAddCity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Ajouter une ville",
                hintStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
          IconButton(
            onPressed: (() => onAddCity(controller.text)),
            icon: Icon(Icons.add_location, color: Colors.deepOrange, size: 36),
          ),
        ],
      ),
    );
  }
}