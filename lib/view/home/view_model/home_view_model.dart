import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:seyahat_asistani/core/init/cache/cache_manager.dart';
import 'package:seyahat_asistani/core/init/navigation/navigation_service.dart';
import 'package:weather/weather.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/travel_model.dart';

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

  late GoogleMapController mapController;
  @observable
  Set<Marker> markers = {};
  @observable
  Set<Marker> closeMarkers = {};
  @observable
  LatLng lastMapPosition = LatLng(37.3741, -122.0771);
  @observable
  MapType currentMapType = MapType.normal;

  PolylinePoints polylinePoints = PolylinePoints();

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

  Container statisticCard(BuildContext context, String header, String type) {
    String? cacheText;

    if (type == "Hava")
      cacheText = isWeatherNotNull ? weather!.weatherDescription : "";
    if (type == "Yürüme")
      cacheText = CacheManager.instance.getUser!.totalWalk + " KM";
    if (type == "Araba")
      cacheText = CacheManager.instance.getUser!.totalDrive + " KM";

    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: MediaQuery.of(context).size.height / 7,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(header,
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.bold))),
          ),
          Text(
            cacheText!,
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @action
  onCameraMove(CameraPosition cameraPosition) {
    lastMapPosition = cameraPosition.target;
  }

  @action
  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition = position;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
    }).catchError((e) {});
  }

  @action
  onAddMarkerButtonPressed() {
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(lastMapPosition.toString()),
      position: lastMapPosition,
      icon: BitmapDescriptor.defaultMarker,
    ));
    //NavigationService.instance.navigateToPage()
    print(getDistance(currentPosition!.latitude, currentPosition!.longitude,
            markers.last.position.latitude, markers.last.position.longitude) /
        1000);
  }

  getDistance(double originLatitude, double originLongitude,
      double destinationLatitude, double destinationLongitude) {
    double distance = Geolocator.distanceBetween(originLatitude,
        originLongitude, destinationLatitude, destinationLongitude);
    return distance;
  }

  TravelModel setTravelModel() {
    double distance = getDistance(
            currentPosition!.latitude,
            currentPosition!.longitude,
            markers.last.position.latitude,
            markers.last.position.longitude) /
        1000;
    return TravelModel(
        start: LatLng(currentPosition!.latitude, currentPosition!.longitude),
        finish: LatLng(
            markers.last.position.latitude, markers.last.position.longitude),
        fuel: double.parse(CacheManager.instance.getUser!.fuelCost),
        calories: distance / 1.6 * 250,
        carbon: distance / 1.6 * 87,
        distance: distance,
        weatherDegree: weather!.temperature!.celsius,
        weatherDesc: weather!.weatherDescription);
  }
}
