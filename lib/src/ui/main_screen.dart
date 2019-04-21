import 'package:cityplaces/src/ui/recomended_places.dart';
import 'package:cityplaces/src/ui/map_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Лучшие места"),
      ),
      body: FavoritePlacesScreen(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MapScreen())),
      ),
    );
  }
}
