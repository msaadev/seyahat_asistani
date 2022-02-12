import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:seyahat_asistani/core/constants/app_constants.dart';
import 'package:seyahat_asistani/core/init/cache/cache_manager.dart';
import 'package:seyahat_asistani/core/init/navigation/navigation_service.dart';
import 'package:seyahat_asistani/core/models/user.dart';
import 'package:seyahat_asistani/main.dart';
import 'package:seyahat_asistani/view/home/view/home_view.dart';

import '../../../../core/services/database_service.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  Future login({required String email, required String password}) async {
    debugPrint('$email ve $password');
    var request = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (request.user != null) {
      var dat = DatabaseService.instance.getUserData(request.user!.uid);
      var userdata;
      dat.then((e) async {
        userdata = UserData(
            uid: e.data()["uid"],
            email: e.data()["email"],
            name: e.data()["name"],
            fuelCost: e.data()["fuelCost"],
            totalCalories: e.data()["totalCalories"],
            totalDrive: e.data()["totalDrive"],
            totalWalk: e.data()["totalWalk"]);
        await CacheManager.instance.setUserData(userdata);
        NavigationService.instance
            .navigateToPageWidgetClear(page: const HomeView());
      });
    } else {
      AppConstants.showErrorToas(message: 'Error');
    }
  }
}
