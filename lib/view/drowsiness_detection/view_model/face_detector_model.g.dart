// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_detector_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FaceDetectorModel on _FaceDetectorModelBase, Store {
  final _$currentPositionAtom =
      Atom(name: '_FaceDetectorModelBase.currentPosition');

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

  final _$markersAtom = Atom(name: '_FaceDetectorModelBase.markers');

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

  final _$closeMarkersAtom = Atom(name: '_FaceDetectorModelBase.closeMarkers');

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
      Atom(name: '_FaceDetectorModelBase.lastMapPosition');

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

  final _$currentMapTypeAtom =
      Atom(name: '_FaceDetectorModelBase.currentMapType');

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

  final _$allDataAtom = Atom(name: '_FaceDetectorModelBase.allData');

  @override
  dynamic get allData {
    _$allDataAtom.reportRead();
    return super.allData;
  }

  @override
  set allData(dynamic value) {
    _$allDataAtom.reportWrite(value, super.allData, () {
      super.allData = value;
    });
  }

  final _$getCurrentLocationAsyncAction =
      AsyncAction('_FaceDetectorModelBase.getCurrentLocation');

  @override
  Future getCurrentLocation() {
    return _$getCurrentLocationAsyncAction
        .run(() => super.getCurrentLocation());
  }

  final _$_FaceDetectorModelBaseActionController =
      ActionController(name: '_FaceDetectorModelBase');

  @override
  dynamic onCameraMove(CameraPosition cameraPosition) {
    final _$actionInfo = _$_FaceDetectorModelBaseActionController.startAction(
        name: '_FaceDetectorModelBase.onCameraMove');
    try {
      return super.onCameraMove(cameraPosition);
    } finally {
      _$_FaceDetectorModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onAddMarkerButtonPressed() {
    final _$actionInfo = _$_FaceDetectorModelBaseActionController.startAction(
        name: '_FaceDetectorModelBase.onAddMarkerButtonPressed');
    try {
      return super.onAddMarkerButtonPressed();
    } finally {
      _$_FaceDetectorModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPosition: ${currentPosition},
markers: ${markers},
closeMarkers: ${closeMarkers},
lastMapPosition: ${lastMapPosition},
currentMapType: ${currentMapType},
allData: ${allData}
    ''';
  }
}
