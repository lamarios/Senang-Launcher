import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:simple_launcher/app_list/models/app_data.dart';
import 'package:simple_launcher/settings/views/screens/app_settings.dart';
import 'package:simple_launcher/settings/views/screens/color_settings.dart';
import 'package:simple_launcher/settings/views/screens/layout_settings.dart';
import 'package:simple_launcher/settings/views/screens/text_settings.dart';

const settingsDarkTheme =
    SettingsThemeData(settingsListBackground: Colors.transparent);
const settingsLightTheme =
    SettingsThemeData(settingsListBackground: Colors.transparent);

class SettingsSheet extends StatelessWidget {
  final AppData? app;
  final Function(AppData app, bool? hidden) hideApp;

  const SettingsSheet({super.key, this.app, required this.hideApp});

  static Future<void> showSettingsSheet(
      BuildContext context, Widget Function(BuildContext context) builder) {
    return showModalBottomSheet(
        context: context,
        builder: builder,
        enableDrag: true,
        barrierColor: Colors.transparent,
        showDragHandle: true);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      darkTheme: settingsDarkTheme,
      lightTheme: settingsLightTheme,
      sections: [
        if (app != null)
          SettingsSection(title: Text(app!.app!.appName), tiles: [
            SettingsTile(
              leading: const Icon(Icons.info),
              title: const Text('App info'),
              onPressed: (context) =>
                  DeviceApps.openAppSettings(app!.app!.packageName),
            ),
            SettingsTile(
              leading: const Icon(Icons.delete),
              title: const Text('Uninstall'),
              onPressed: (context) =>
                  DeviceApps.uninstallApp(app!.app!.packageName),
            ),
            SettingsTile(
              title: const Text('Hide app'),
              onPressed: (context) => hideApp(app!, true),
              leading: const Icon(Icons.remove_red_eye_rounded),
            )
          ]),
        SettingsSection(title: const Text('Settings'), tiles: [
          SettingsTile(
            leading: const Icon(Icons.apps),
            title: const Text('Apps settings'),
            onPressed: (context) => showSettingsSheet(
                context, (context) => const AppSettingsSheet()),
          ),
          SettingsTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Text settings'),
            onPressed: (context) => showSettingsSheet(
                context, (context) => const TextSettingsSheet()),
          ),
          SettingsTile(
              leading: const Icon(Icons.format_paint),
              title: const Text('Color settings'),
              onPressed: (context) => showSettingsSheet(
                  context, (context) => const ColorSettings())),
          SettingsTile(
              leading: const Icon(Icons.square_foot),
              title: const Text('Layout settings'),
              onPressed: (context) => showSettingsSheet(
                  context, (context) => const LayoutSettingsSheet())),
        ])
      ],
    );
  }
}
