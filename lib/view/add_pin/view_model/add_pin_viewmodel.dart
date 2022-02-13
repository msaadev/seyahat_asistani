import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/services/database_service.dart';
part 'add_pin_viewmodel.g.dart';

class AddPinViewModel = _AddPinViewModelBase with _$AddPinViewModel;

abstract class _AddPinViewModelBase with Store {
  final LatLng myPosition;

  final TextEditingController controller = TextEditingController();

  _AddPinViewModelBase({
    required this.myPosition,
  }) {
    pin = myPosition;
    AppConstants.showSuccesToas(
        message: 'Yol durumu bildirmek istediğiniz konuma dokunun');
  }

  @observable
  LatLng? pin;

  @observable
  bool isLoading = false;

  @action
  void addPin(LatLng p) => pin = p;

  savePin() async {
    if (controller.text.isNotEmpty) {
      _changeLoading();
      await DatabaseService.instance
          .createPinInFirestore(controller.text, pin!.latitude, pin!.longitude);
      AppConstants.showSuccesToas(message: 'Pin başarıyla eklendi');
      _changeLoading();
      NavigationService.instance.navPop;
    } else {
      AppConstants.showErrorToas(message: 'Lütfen açıklama giriniz');
    }
  }

  @action
  _changeLoading() {
    isLoading = !isLoading;
  }
}
