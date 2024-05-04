import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:simple_launcher/settings/state/settings.dart';
import 'package:simple_launcher/settings/views/screens/color_picker.dart';
import 'package:simple_launcher/settings/views/screens/settings.dart';

class ColorSettings extends StatelessWidget {
  const ColorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
      final cubit = context.read<SettingsCubit>();
      return SettingsList(
        darkTheme:
            const SettingsThemeData(settingsListBackground: Colors.transparent),
        lightTheme:
            const SettingsThemeData(settingsListBackground: Colors.transparent),
        sections: [
          SettingsSection(title: const Text('Text color'), tiles: [
            SettingsTile.switchTile(
              title: const Text('Color tint'),
              description: const Text(
                  'The bigger the text it will tend to go black (light theme) or white (dart theme)'),
              initialValue: settings.tintColor,
              onToggle: (value) =>
                  cubit.updateSetting(tintColorSettingName, value.toString()),
            ),
            SettingsTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: colors.outline, width: 1),
                    shape: BoxShape.circle,
                    color: settings.color),
              ),
              title: const Text('Text base color'),
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
          SettingsSection(title: const Text('Notification color'), tiles: [
            SettingsTile.switchTile(
              title: const Text('Color app with notifications'),
              description: const Text(
                  'When an app has a notification, it will be displayed in a different color'),
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
              title: const Text('Notification color'),
              onPressed: (context) => SettingsSheet.showSettingsSheet(
                  context,
                  (context) => ColorPickerSheet(
                        color: settings.notificationColor,
                        onChanged: (value) {
                          return cubit.updateSetting(
                              notificationColorSettingName,
                              value.value.toString());
                        },
                      )),
            )
          ])
        ],
      );
    });
  }
}
