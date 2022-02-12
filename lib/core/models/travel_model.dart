import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TravelModel {
  final LatLng start;
  final LatLng finish;
  final double fuel;
  final double calories;
  final double carbon;
  final double distance;
  final double? weatherDegree;
  final String? weatherDesc;

  const TravelModel({
    required this.start,
    required this.finish,
    required this.fuel,
    required this.calories,
    required this.carbon,
    required this.distance,
    required this.weatherDegree,
    required this.weatherDesc,
    }
  );

}