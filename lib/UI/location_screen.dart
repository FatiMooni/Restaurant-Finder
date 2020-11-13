import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Where to find a restaurant ?"),),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search Restaurant",
                hintText: "enter a place or name ...",
                icon: Icon(Icons.location_city)),
            onChanged: (query) => {},
            ),
          ),
          Expanded(child: _buildResults())
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Center(child: Text("list of restaurants"),);
  }
}