import 'package:flutter/material.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/forecast.dart';

void main() {
  runApp(MaterialApp(
    // home: home(),
    routes: {
      '/':(context)=>home(),
      '/forecast':(context)=>forecast(),
    },
  ));
}


