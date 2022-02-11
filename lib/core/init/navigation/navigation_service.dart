import 'package:flutter/material.dart';

import 'i_navigation_service.dart';



class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool Function(Route route) get removeAllRoutes =>
      (Route<dynamic> route) => false;
  @override
  Future navigateToPage({required String path, Object? data}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
  }

  @override
  Future navigateToPageClear({required String path, Object? data}) async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path, removeAllRoutes, arguments: data);
  }

  @override
  Future get navPop async => navigatorKey.currentState!.pop();

  @override
  bool get canPop => navigatorKey.currentState!.canPop();

  @override
  Future navigateToPageWidget({required Widget page}) async {
    await navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Future navigateToPageWidgetClear({required Widget page}) async {
    await navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page), removeAllRoutes);
  }

  @override
  Future navigateToPageWidgetReplace({required Widget page}) async {
    await navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
  }
}
