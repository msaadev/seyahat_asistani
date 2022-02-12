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
  String toString() {
    return '''
isCar: ${isCar}
    ''';
  }
}
