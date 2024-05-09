import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:senang_launcher/router.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/plus_minus.dart';

class AppSettingsSheet extends StatelessWidget {
  const AppSettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
      final cubit = context.read<SettingsCubit>();
      return SettingsList(
        darkTheme:
            const SettingsThemeData(settingsListBackground: Colors.transparent),
        lightTheme:
            const SettingsThemeData(settingsListBackground: Colors.transparent),
        sections: [
          SettingsSection(title: Text(locals.appSettings), tiles: [
            SettingsTile(
              title: Text(locals.daysOfStats),
              description: Text(locals.daysOfStatsDescription),
              trailing: PlusMinus(
                value: settings.dataDays.toDouble(),
                step: 1,
                min: 1,
                onChanged: (newValue) => cubit.updateSetting(
                    dataDaysSettingName, newValue.toInt().toString()),
              ),
            ),
/*
            SettingsTile.switchTile(
              enabled: settings.showAppNames,
              initialValue: settings.showAppIcons,
              onToggle: (value) => cubit.updateSetting(
                  showAppIconsSettingName, value.toString()),
              title: const Text('Show app icons'),
              leading: const Icon(Icons.touch_app_rounded),
            ),
            SettingsTile.switchTile(
              enabled: settings.showAppIcons,
              initialValue: settings.showAppNames,
              onToggle: (value) => cubit.updateSetting(
                  showAppNamesSettingName, value.toString()),
              title: const Text('Show app names'),
              leading: const Icon(Icons.title),
            ),
*/
            SettingsTile.navigation(
              title: Text(locals.stats),
              leading: const Icon(Icons.auto_graph),
              onPressed: (context) =>
                  AutoRouter.of(context).push(const StatsRoute()),
            ),
            SettingsTile.navigation(
              title: Text(locals.hiddenApps),
              leading: const Icon(Icons.remove_red_eye),
              onPressed: (context) =>
                  AutoRouter.of(context).push(const HiddenAppRoute()),
            )
          ]),
          SettingsSection(title: Text(locals.wallpaper), tiles: [
            SettingsTile.switchTile(
              title: Text(locals.showWallpaper),
              initialValue: settings.showWallPaper,
              onToggle: (value) async {
                var status = await Permission.manageExternalStorage.request();
                print(status);
                if (status.isGranted) {
                  cubit.updateSetting(
                      showWallPaperSettingName, value.toString());
                }
              },
            ),
            SettingsTile(
              title: Text(locals.wallpaperDimming),
              trailing: PlusMinus(
                value: settings.wallPaperDim,
                step: 0.05,
                max: 1,
                min: 0,
                onChanged: (newValue) => cubit.updateSetting(
                    wallPaperDimSettingName, newValue.toString()),
              ),
            ),
            SettingsTile(
              title: Text(locals.wallpaperBlur),
              description: Text(locals.wallpaperBlurWarning),
              trailing: PlusMinus(
                value: settings.wallpaperBlur,
                step: 1,
                max: 100,
                min: 0,
                onChanged: (newValue) => cubit.updateSetting(
                    wallpaperBlurSettingName, newValue.toString()),
              ),
            ),
          ])
        ],
      );
    });
  }
}
