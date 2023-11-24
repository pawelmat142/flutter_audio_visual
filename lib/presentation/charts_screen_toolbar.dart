import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/app_style.dart';
import 'package:flutter_audio_visual/model/chart_setting.dart';
import 'package:flutter_audio_visual/model/charts_state.dart';
import 'package:flutter_audio_visual/presentation/dialog/app_snackbar.dart';
import 'package:flutter_audio_visual/presentation/dialog/toolbar.dart';
import 'package:flutter_audio_visual/presentation/setups_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsScreenToolbar extends StatelessWidget {
  const ChartsScreenToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChartsCubit>(context);

    return BlocBuilder<ChartsCubit, ChartsState>(
      builder: (ctx, state) {
        return Toolbar(
          defaultColor: AppColor.primary,
          defaultLabelColor: AppColor.primary,

          toolbarItems: [
            ToolBarItem(
                label: 'add',
                menuLabel: 'add chart',
                icon: Icons.add,
                onTap: () => selectTypeDialog(context, cubit)
            ),
            ToolBarItem(
                label: state.running ? 'stop' : 'start',
                icon: state.running ? Icons.stop_circle : Icons.play_circle,
                color: state.running ? Colors.redAccent : Colors.blueAccent,
                onTap: () => state.running ? cubit.stop() : cubit.start()
            ),
          ],

          menuItems: [
            ToolBarItem(
                icon: Icons.list,
                label: 'Setups list',
                onTap: () => Navigator.pushNamed(context, SetupsScreen.id)
            ),
            ToolBarItem(
                label: 'save',
                icon: Icons.save,
                onTap: () => cubit.saveSetup().then((_) {
                  AppSnackBar.show(context: context, text: 'saved!');
                  Navigator.pushNamed(context, SetupsScreen.id);
                })
            ),
            ToolBarItem(
                label: 'clear signal state',
                icon: Icons.cleaning_services,
                onTap: cubit.reset
            ),

          ],
        );
      }
    );
  }

  selectTypeDialog(BuildContext context, ChartsCubit cubit) {
    showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceBetween,
        title: const Text('select type'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx);
          }, child: const Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.pop(ctx, ChartType.time);
          }, child: const Text('TIME')),
          TextButton(onPressed: () {
            Navigator.pop(ctx, ChartType.frequency);
          }, child: const Text('FREQ')),
        ],
      );
    }).then((type) {
      if (type is ChartType) {
        cubit.addChart(type);
      }
    });
  }
}
