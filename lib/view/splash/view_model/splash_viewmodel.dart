import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';
import 'package:mobx/mobx.dart';
import 'package:seyahat_asistani/core/init/navigation/navigation_service.dart';
import 'package:seyahat_asistani/main.dart';
import 'package:seyahat_asistani/view/auth/auth_view/view/auth_view.dart';
import 'package:seyahat_asistani/view/home/view/home_view.dart';
part 'splash_viewmodel.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase with Store {
  final BuildContext context;
  late final NavigationService navigationService;

  _SplashViewModelBase({required this.context}) {
    navigationService = NavigationService.instance;
  }

  void get checkLogin {
    Future.delayed(1.secondDuration).then((value) {
      navigationService.navigateToPageWidgetClear(page: const AuthView());
      print(firebaseAuth.currentUser);
      if (firebaseAuth.currentUser == null) {
        navigationService.navigateToPageWidgetClear(page: const AuthView());
      } else {
        navigationService.navigateToPageWidgetClear(page: const HomeView());
      }
    });
  }
}
