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

  final _$getCurrentWeatherAsyncAction =
      AsyncAction('_HomeViewModelBase.getCurrentWeather');

  @override
  Future getCurrentWeather() {
    return _$getCurrentWeatherAsyncAction.run(() => super.getCurrentWeather());
  }

  @override
  String toString() {
    return '''
weather: ${weather},
currentPosition: ${currentPosition},
isPositionNotNull: ${isPositionNotNull},
isWeatherNotNull: ${isWeatherNotNull}
    ''';
  }
}
