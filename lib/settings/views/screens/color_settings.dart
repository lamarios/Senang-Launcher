import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:senang_launcher/settings/views/screens/color_picker.dart';
import 'package:senang_launcher/settings/views/screens/settings.dart';

class ColorSettings extends StatelessWidget {
  const ColorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
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
          SettingsSection(title: Text(locals.textColor), tiles: [
            SettingsTile.switchTile(
              title: Text(locals.colorTint),
              description: Text(locals.colorTintDescription),
              initialValue: settings.tintColor,
              onToggle: (value) =>
                  cubit.updateSetting(tintColorSettingName, value.toString()),
            ),
            SettingsTile.switchTile(
              title: Text(locals.invertTint),
              description: Text(locals.invertTintDescription),
              initialValue: settings.invertTint,
              onToggle: (value) =>
                  cubit.updateSetting(invertTintSettingName, value.toString()),
            ),
            SettingsTile.switchTile(
              title: Text(locals.dynamicColors),
              description: Text(locals.dynamicColorsExplanation),
              initialValue: settings.dynamicColors,
              onToggle: (value) => cubit.updateSetting(
                  useDynamicColorSettingName, value.toString()),
            ),
            SettingsTile(
              enabled: !settings.dynamicColors,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: colors.outline, width: 1),
                    shape: BoxShape.circle,
                    color:
                        settings.dynamicColors ? Colors.grey : settings.color),
              ),
              title: Text(locals.textBaseColor),
              onPressed: (context) => SettingsSheet.showSettingsSheet(
                  context,
                  (context) => ColorPickerSheet(
                        color: settings.color,
                        onChanged: (value) {
                          return cubit.updateSetting(
                              colorSettingName, value.value.toString());
                        },
                      )),
            )
          ]),
          SettingsSection(title: Text(locals.notificationColor), tiles: [
            SettingsTile.switchTile(
              title: Text(locals.colorAppWithNotification),
              description: Text(locals.colorAppWithNotificationDescription),
              initialValue: settings.colorOnNotifications,
              onToggle: (value) => cubit.updateSetting(
                  colorOnNotificationSettingName, value.toString()),
            ),
            SettingsTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: colors.outline, width: 1),
                    shape: BoxShape.circle,
                    color: settings.notificationColor),
              ),
              title: Text(locals.notificationColor),
              onPressed: (context) => SettingsSheet.showSettingsSheet(
                  context,
                  (context) => ColorPickerSheet(
                        color: settings.notificationColor,
                        onChanged: (value) => cubit.updateSetting(
                            notificationColorSettingName,
                            value.value.toString()),
                      )),
            )
          ]),
          SettingsSection(title: Text(locals.theme), tiles: [
            SettingsTile.switchTile(
              enabled: Theme.of(context).brightness == Brightness.dark,
              title: Text(locals.blackBackground),
              initialValue: settings.blackBackground,
              onToggle: (value) => cubit.updateSetting(
                  blackBackGroundSettingName, value.toString()),
            ),
            SettingsTile(
              title: Text(locals.theme),
              trailing: DropdownButton<ThemeMode>(
                value: settings.themeMode ?? ThemeMode.system,
                items: [
                  ...ThemeMode.values.map((e) => DropdownMenuItem<ThemeMode>(
                      value: e,
                      child: Text(switch (e) {
                        ThemeMode.dark => locals.darkMode,
                        ThemeMode.light => locals.lightMode,
                        ThemeMode.system => locals.followSystem,
                      })))
                ],
                onChanged: (ThemeMode? value) {
                  if (value == null || value == ThemeMode.system) {
                    cubit.deleteSetting(themeSettingName);
                  } else {
                    cubit.updateSetting(themeSettingName, value.name);
                  }
                },
              ),
            )
          ]),
        ],
      );
    });
  }
}
