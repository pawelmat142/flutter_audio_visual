import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/model/chart_setting.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/services/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPopup extends StatelessWidget {

  final ChartSetting setting;

  const SettingPopup(this.setting, {
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChartsCubit>(context);

    final settingJson = setting.toJson;

    return AlertDialog(

      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
          showDialog(context: context, builder: (ctx) {
            return AlertDialog(
              title: const Text('SURE?'),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(ctx);
                }, child: const Text('Cancel')),
                TextButton(onPressed: () {
                  Navigator.pop(ctx);
                  cubit.removeChart(setting);
                }, child: const Text('OK'))
              ],
            );
          });
        }, child: const Text('REMOVE CHART')),
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Text('OK'))
      ],

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: settingJson.keys
          .where((field) => settingJson[field] is num)
          .map((field) => SettingsTile(
            title: field,
            currentValue: settingJson[field],
            valueSetter: (num value) {
              cubit.emitSetting(
                  setting: setting,
                  value: value,
                  field: field
              );
            })
        ).toList(),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {

  final String title;
  final num currentValue;
  final Function(num) valueSetter;

  const SettingsTile({
    required this.title,
    required this.currentValue,
    required this.valueSetter,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: AppStyle.primaryMedium,),
      trailing: Text(Util.valueDisplay(currentValue),
          style: AppStyle.mediumDark
      ),
      onTap: () {
        Navigator.pop(context);
        showPopup(context,
          title: title,
          value: currentValue,
        ).then((value) {
          if (value is String) {
            final number = num.parse(value);
            valueSetter(number);
          }
        });
      },
    );
  }

  static showPopup(BuildContext context, {
    required String title,
    required num value,
  }) {
    final controller = TextEditingController(
        text: value.toString()
    );
    return showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          autofocus: true,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx);
          }, child: const Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.pop(ctx, controller.value.text);
          }, child: const Text('OK'))
        ],

      );
    });
  }
}
