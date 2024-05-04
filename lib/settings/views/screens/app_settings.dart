import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:simple_launcher/router.dart';
import 'package:simple_launcher/settings/state/settings.dart';

import '../components/plus_minus.dart';

class AppSettingsSheet extends StatelessWidget {
  const AppSettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
      final cubit = context.read<SettingsCubit>();
      return SettingsList(
        darkTheme:
            const SettingsThemeData(settingsListBackground: Colors.transparent),
        lightTheme:
            const SettingsThemeData(settingsListBackground: Colors.transparent),
        sections: [
          SettingsSection(title: const Text('App settings'), tiles: [
            SettingsTile(
              title: const Text('Days of stats'),
              description: const Text(
                  'How many days of usage to use to determine the size of the apps'),
              trailing: PlusMinus(
                value: settings.dataDays.toDouble(),
                step: 1,
                min: 1,
                onChanged: (newValue) => cubit.updateSetting(
                    dataDaysSettingName, newValue.toInt().toString()),
              ),
            ),
            SettingsTile.navigation(
              title: const Text('Hidden apps'),
              leading: const Icon(Icons.remove_red_eye),
              onPressed: (context) =>
                  AutoRouter.of(context).push(const HiddenAppRoute()),
            )
          ]),
/*
          SettingsSection(title: Text('Wallpaper'), tiles: [
            SettingsTile.switchTile(
              title: Text('Show wallpaper'),
              initialValue: settings.showWallPaper,
              onToggle: (value) => cubit.updateSetting(
                  showWallPaperSettingName, value.toString()),
            ),
            SettingsTile(
              title: Text('Wallpaper dimming'),
              trailing: PlusMinus(
                value: settings.wallPaperDim,
                step: 0.05,
                max: 1,
                min: 0,
                onChanged: (newValue) => cubit.updateSetting(
                    wallPaperDimSettingName, newValue.toString()),
              ),
            ),
          ])
*/
        ],
      );
    });
  }
}
