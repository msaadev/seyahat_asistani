import 'package:flutter/material.dart';

abstract class INavigationService {
  Future navigateToPage({required String path, Object? data});
  Future navigateToPageClear({required String path, Object? data});
  Future navigateToPageWidget({required Widget page});
  Future navigateToPageWidgetClear({required Widget page});
  Future navigateToPageWidgetReplace({required Widget page});
  Future get navPop;
  bool get canPop;
}
