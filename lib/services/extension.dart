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

  String get cutDotZero {
    if (length > 2) {
      final lastTwoLetters = substring(length-2);
      if (lastTwoLetters == '.0') {
        return substring(0, length-2);
      }
    }
    return this;
  }

  String get cutZeroDot {
    if (length > 2) {
      final firstTwoLetters = substring(0, 2);
      if (firstTwoLetters == '0.') {
        return substring(1, length);
      }
    }
    return this;
  }

  String get cutAfterDot {
    if (contains('.')) {
      final split = this.split('.');
      final decimalPart = split[1];
      if (decimalPart.length > 1) {
        return '${split[0]}.${decimalPart.substring(0,1)}';
      }
    }
    return this;
  }
}