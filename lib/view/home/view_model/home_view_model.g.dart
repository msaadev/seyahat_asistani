// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  Computed<bool>? _$isPositionNotNullComputed;

  @override
  bool get isPositionNotNull => (_$isPositionNotNullComputed ??= Computed<bool>(
          () => super.isPositionNotNull,
          name: '_HomeViewModelBase.isPositionNotNull'))
      .value;
  Computed<bool>? _$isWeatherNotNullComputed;

  @override
  bool get isWeatherNotNull => (_$isWeatherNotNullComputed ??= Computed<bool>(
          () => super.isWeatherNotNull,
          name: '_HomeViewModelBase.isWeatherNotNull'))
      .value;

  final _$weatherAtom = Atom(name: '_HomeViewModelBase.weather');

  @override
  Weather? get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(Weather? value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  final _$currentPositionAtom =
      Atom(name: '_HomeViewModelBase.currentPosition');

  @override
  Position? get currentPosition {
    _$currentPositionAtom.reportRead();
    return super.currentPosition;
  }

  @override
  set currentPosition(Position? value) {
    _$currentPositionAtom.reportWrite(value, super.currentPosition, () {
      super.currentPosition = value;
    });
  }

  final _$markersAtom = Atom(name: '_HomeViewModelBase.markers');

  @override
  Set<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(Set<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$closeMarkersAtom = Atom(name: '_HomeViewModelBase.closeMarkers');

  @override
  Set<Marker> get closeMarkers {
    _$closeMarkersAtom.reportRead();
    return super.closeMarkers;
  }

  @override
  set closeMarkers(Set<Marker> value) {
    _$closeMarkersAtom.reportWrite(value, super.closeMarkers, () {
      super.closeMarkers = value;
    });
  }

  final _$lastMapPositionAtom =
      Atom(name: '_HomeViewModelBase.lastMapPosition');

  @override
  LatLng get lastMapPosition {
    _$lastMapPositionAtom.reportRead();
    return super.lastMapPosition;
  }

  @override
  set lastMapPosition(LatLng value) {
    _$lastMapPositionAtom.reportWrite(value, super.lastMapPosition, () {
      super.lastMapPosition = value;
    });
  }

  final _$currentMapTypeAtom = Atom(name: '_HomeViewModelBase.currentMapType');

  @override
  MapType get currentMapType {
    _$currentMapTypeAtom.reportRead();
    return super.currentMapType;
  }

  @override
  set currentMapType(MapType value) {
    _$currentMapTypeAtom.reportWrite(value, super.currentMapType, () {
      super.currentMapType = value;
    });
  }

  final _$getCurrentWeatherAsyncAction =
      AsyncAction('_HomeViewModelBase.getCurrentWeather');

  @override
  Future getCurrentWeather() {
    return _$getCurrentWeatherAsyncAction.run(() => super.getCurrentWeather());
  }

  final _$getCurrentLocationAsyncAction =
      AsyncAction('_HomeViewModelBase.getCurrentLocation');

  @override
  Future getCurrentLocation() {
    return _$getCurrentLocationAsyncAction
        .run(() => super.getCurrentLocation());
  }

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  dynamic onCameraMove(CameraPosition cameraPosition) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.onCameraMove');
    try {
      return super.onCameraMove(cameraPosition);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
weather: ${weather},
currentPosition: ${currentPosition},
markers: ${markers},
closeMarkers: ${closeMarkers},
lastMapPosition: ${lastMapPosition},
currentMapType: ${currentMapType},
isPositionNotNull: ${isPositionNotNull},
isWeatherNotNull: ${isWeatherNotNull}
    ''';
  }
}
