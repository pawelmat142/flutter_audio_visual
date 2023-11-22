import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/model/charts_setup.dart';
import 'package:flutter_audio_visual/presentation/dialog/sure_dialog.dart';
import 'package:flutter_audio_visual/services/extension.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SetupsScreen extends StatelessWidget {
  static const String id = 'setups_screen';

  const SetupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Saved setups'),),

      body: ValueListenableBuilder(
        valueListenable: ChartsSetup.hiveBox.listenable(),
        builder: (context, box, widget) {
          return ListView(
            children: box.values.map((setup) => ListTile(
              title: Text(setup.name!,),
              subtitle: Text(setup.modified.format),
              trailing: DeleteSetupButton(setup),
            )).toList(),
          );
        },
      ),
    );
  }
}

class DeleteSetupButton extends StatelessWidget {

  final ChartsSetup setup;

  const DeleteSetupButton(this.setup, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        showDialog(context: context, builder: (ctx) {
          return const SureAlert();
        }).then((value) {
          if (value == true) {
            setup.delete();
          }
        });
      });
  }
}
