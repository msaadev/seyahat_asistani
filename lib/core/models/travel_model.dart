import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather/weather.dart';

class TravelModel {
  final LatLng start;
  final LatLng finish;
  final double fuel;
  late double calories;
  late double carbon;
  late double distance;
  final Weather? weather;
  late double totalFuel;

  TravelModel({
    required this.start,
    required this.finish,
    required this.fuel,
    this.weather,
  }) {
    distance = _calculateDistance;
    calories = distance * 270;
    carbon = distance * 0.17;
    totalFuel = (distance / 100) * fuel;
  }

  double get _calculateDistance =>
      Geolocator.distanceBetween(
          start.latitude, start.longitude, finish.latitude, finish.longitude) /
      1000;
}
