import 'package:flutter/material.dart';

abstract class AppSnackBar {

  static show({ required BuildContext context, required String text }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: const Duration(milliseconds: 1000)),
    );
  }
}