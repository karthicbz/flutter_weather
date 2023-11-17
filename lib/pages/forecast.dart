import 'package:flutter/material.dart';

class forecast extends StatefulWidget {
  const forecast({super.key});

  @override
  State<forecast> createState() => _forecastState();
}

class _forecastState extends State<forecast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}
