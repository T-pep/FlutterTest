import 'package:flutter/material.dart';

double toDegreeCel(double tempInK) {
  double tempInC = tempInK - 273.15;
  return double.parse(tempInC.toStringAsFixed(1));
}

IconData iconWeather(String currentSky) {
  switch (currentSky) {
    case 'Clouds':
      return Icons.cloud;
    case 'Rain':
      return Icons.water_drop;
    default:
      return Icons.sunny;
  }
}
