// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_pin_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddPinViewModel on _AddPinViewModelBase, Store {
  final _$pinAtom = Atom(name: '_AddPinViewModelBase.pin');

  @override
  LatLng? get pin {
    _$pinAtom.reportRead();
    return super.pin;
  }

  @override
  set pin(LatLng? value) {
    _$pinAtom.reportWrite(value, super.pin, () {
      super.pin = value;
    });
  }

  final _$_AddPinViewModelBaseActionController =
      ActionController(name: '_AddPinViewModelBase');

  @override
  void addPin(LatLng p) {
    final _$actionInfo = _$_AddPinViewModelBaseActionController.startAction(
        name: '_AddPinViewModelBase.addPin');
    try {
      return super.addPin(p);
    } finally {
      _$_AddPinViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pin: ${pin}
    ''';
  }
}
