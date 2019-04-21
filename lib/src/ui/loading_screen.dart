import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Loading"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}