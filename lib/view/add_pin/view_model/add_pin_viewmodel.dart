import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:seyahat_asistani/core/constants/app_constants.dart';
part 'add_pin_viewmodel.g.dart';

class AddPinViewModel = _AddPinViewModelBase with _$AddPinViewModel;

abstract class _AddPinViewModelBase with Store {
  final LatLng myPosition;

  _AddPinViewModelBase({
    required this.myPosition,
  }) {
    pin = myPosition;
    AppConstants.showSuccesToas(
        message: 'Yol durumu bildirmek istediğiniz konuma dokunun');
  }

  @observable
  LatLng? pin;

  @action
  void addPin(LatLng p) => pin = p;

  savePin() {}
}
