import 'package:flutter/material.dart';

class SureAlert extends StatelessWidget {
  const SureAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('SURE?'),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context, false);
        }, child: const Text('Cancel')),
        TextButton(onPressed: () {
          Navigator.pop(context, true);
        }, child: const Text('OK'))
      ],
    );
  }
}
