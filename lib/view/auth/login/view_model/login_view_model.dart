import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:seyahat_asistani/core/constants/app_constants.dart';
import 'package:seyahat_asistani/core/init/navigation/navigation_service.dart';
import 'package:seyahat_asistani/main.dart';
import 'package:seyahat_asistani/view/home/view/home_view.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  Future login({required String email, required String password}) async {
    debugPrint('$email ve $password');
    var request = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (request.user != null) {
      NavigationService.instance
          .navigateToPageWidgetClear(page: const HomeView());
    } else {
      AppConstants.showErrorToas(message: 'Error');
    }
  }
}
