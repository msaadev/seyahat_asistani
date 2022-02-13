import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import '../../select_mode/view/select_mode.dart';
import 'package:weather/weather.dart';
import '../../../core/init/navigation/navigation_service.dart';
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

  GoogleMapController? mapController;

  @observable
  LatLng? finishMarker;

  @computed
  bool get isFinishNotNull => finishMarker != null;

  @observable
  MapType currentMapType = MapType.normal;

  @action
  getCurrentWeather() async {
    if (isPositionNotNull) {
      Weather w = await weatherFactory.currentWeatherByLocation(
          currentPosition!.latitude, currentPosition!.longitude);
      weather = w;
    }
  }

  @action
  streamPosition() {
    positionStream = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                distanceFilter: 5, accuracy: LocationAccuracy.medium))
        .listen((event) {
      mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(event.latitude, event.longitude)));
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

  @action
  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition = position;
      mapController?.animateCamera(
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
  addMarker(LatLng position) {
    finishMarker = position;
  }


  navigateToSelectMode(){
    NavigationService.instance.navigateToPageWidget(
        page: SelectModeView(
            travelModel: TravelModel(
                finish: finishMarker!,
                fuel: 7,
                start: LatLng(
                    currentPosition!.latitude, currentPosition!.longitude),
                weather: weather)));
  }
}
