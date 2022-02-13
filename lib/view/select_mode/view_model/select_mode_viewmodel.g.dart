// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_mode_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SelectModeViewModel on _SelectModeViewModelBase, Store {
  final _$isCarAtom = Atom(name: '_SelectModeViewModelBase.isCar');

  @override
  bool get isCar {
    _$isCarAtom.reportRead();
    return super.isCar;
  }

  @override
  set isCar(bool value) {
    _$isCarAtom.reportWrite(value, super.isCar, () {
      super.isCar = value;
    });
  }

  final _$markersAtom = Atom(name: '_SelectModeViewModelBase.markers');

  @override
  ObservableSet<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(ObservableSet<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$currentPositionAtom =
      Atom(name: '_SelectModeViewModelBase.currentPosition');

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

  final _$closeMarkersAtom =
      Atom(name: '_SelectModeViewModelBase.closeMarkers');

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
      Atom(name: '_SelectModeViewModelBase.lastMapPosition');

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
      Atom(name: '_SelectModeViewModelBase.currentMapType');

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

  final _$allDataAtom = Atom(name: '_SelectModeViewModelBase.allData');

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

  final _$getDataAsyncAction = AsyncAction('_SelectModeViewModelBase.getData');

  @override
  Future<void> getData({required BuildContext context}) {
    return _$getDataAsyncAction.run(() => super.getData(context: context));
  }

  final _$_SelectModeViewModelBaseActionController =
      ActionController(name: '_SelectModeViewModelBase');

  @override
  void change(bool v) {
    final _$actionInfo = _$_SelectModeViewModelBaseActionController.startAction(
        name: '_SelectModeViewModelBase.change');
    try {
      return super.change(v);
    } finally {
      _$_SelectModeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onCameraMove(CameraPosition cameraPosition) {
    final _$actionInfo = _$_SelectModeViewModelBaseActionController.startAction(
        name: '_SelectModeViewModelBase.onCameraMove');
    try {
      return super.onCameraMove(cameraPosition);
    } finally {
      _$_SelectModeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isCar: ${isCar},
markers: ${markers},
currentPosition: ${currentPosition},
closeMarkers: ${closeMarkers},
lastMapPosition: ${lastMapPosition},
currentMapType: ${currentMapType},
allData: ${allData}
    ''';
  }
}
