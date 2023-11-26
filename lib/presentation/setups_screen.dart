import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/model/charts_setup.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/presentation/charts_screen.dart';
import 'package:flutter_audio_visual/presentation/dialog/app_snackbar.dart';
import 'package:flutter_audio_visual/presentation/dialog/sure_dialog.dart';
import 'package:flutter_audio_visual/services/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

          final setups = box.values.toList();
          setups.sort((a, b) => b.modified.compareTo(a.modified));

          return ListView(
            children: setups.map((setup) => ListTile(
              title: Text(setup.name ?? 'Long press to add name...',),
              subtitle: Text(setup.modified.format, style: AppStyle.smallPrimary),
              trailing: DeleteSetupButton(setup),
              onTap: () => loadSetup(context, setup),
              onLongPress: () => onSetupLongPress(context, setup),
            )).toList(),
          );
        },
      ),
    );
  }

  loadSetup(BuildContext context, ChartsSetup setup) {
    final cubit = BlocProvider.of<ChartsCubit>(context);
    cubit.loadSetup(setup);
    Future.delayed(const Duration(milliseconds: 100), () {
      Navi.popUntilNamed(context, ChartsScreen.id);
    });
  }

  onSetupLongPress(BuildContext context, ChartsSetup setup) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: setup.name is String ? Text(setup.name!) : null,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),

            TextButton(onPressed: () {
              Navigator.pop(context);
              setup.copy().then((_) => AppSnackBar.show(context: context, text: 'Copied!'));
            }, child: const Text('Copy setup')),

            TextButton(onPressed: () {
              Navigator.pop(context);
              setName(context, setup);
            }, child: const Text('Edit name')),

            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text('Cancel')),
          ],
        )
      ],
    ));
  }

  setName(BuildContext context, ChartsSetup setup) {
    showDialog(context: context, builder: (ctx) {
      final controller = TextEditingController();
      controller.text = setup.name ?? '';
      return AlertDialog(
        title: const Text('Enter name'),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx);
          }, child: const Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.pop(ctx);
            setup.name = controller.text;
            setup.save().then((value) {
              AppSnackBar.show(context: context, text: 'saved!');
            });
          }, child: const Text('OK'))
        ],
      );
    });
  }
}

class DeleteSetupButton extends StatelessWidget {

  final ChartsSetup setup;

  const DeleteSetupButton(this.setup, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: AppColor.primary,
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
