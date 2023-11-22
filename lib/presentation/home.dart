import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/presentation/charts_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, ChartsScreen.id);
            }, child: const Text('charts')),

            ElevatedButton(onPressed: () {

            }, child: const Text('test')),
          ],
        ),
      )
    );
  }
}
