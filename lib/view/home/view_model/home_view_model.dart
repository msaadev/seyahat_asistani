import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:weather/weather.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  _HomeViewModelBase() {
    _init();
  }

  Future _init() async {
   await _determinePosition();
    streamPosition();
  }

  WeatherFactory weatherFactory =
      WeatherFactory("fd77a48f72d62a777bd72c361e5625e6");

  @observable
  Weather? weather;

  @observable
  Position? currentPosition;

  late StreamSubscription<Position> positionStream;

  @computed
  bool get isPositionNotNull => currentPosition != null;

  @computed
  bool get isWeatherNotNull => weather != null;

  @action
  getCurrentWeather() async {
    if (isPositionNotNull) {
      Weather w = await weatherFactory.currentWeatherByLocation(
          currentPosition!.latitude, currentPosition!.longitude);
      weather = w;
      print(weather);
    } 
  }

  streamPosition() {
    positionStream = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                distanceFilter: 5, accuracy: LocationAccuracy.medium))
        .listen((event) {
          debugPrint('listening');
      currentPosition = event;
      getCurrentWeather();
    });
  }

 
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
        debugPrint('determine done');
    currentPosition = position;
    getCurrentWeather();

    return position;
  }
}
