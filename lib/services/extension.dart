import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

extension Navi on Navigator {

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Iterable<Route<dynamic>> get routes => NavigationHistoryObserver().history;
  static Iterable<String?> get path => routes.map((Route route) => route.settings.name);

  static bool inStack(String screenId) => routes.any((Route route) => route.settings.name == screenId);

  static remove(BuildContext context, String screenId) {
    Navigator.pop(context, (Route route) => route.settings.name == screenId);
  }

  static popUntilNamed(BuildContext context, String screenId) {
    Navigator.popUntil(context, (Route route) => route.settings.name == screenId);
  }

}

extension DateTimeExtension on DateTime {

  static final formatter = DateFormat('kk:mm dd-MM-yyyy');

  String get format => formatter.format(this);
}

extension StringExtension on String {

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}