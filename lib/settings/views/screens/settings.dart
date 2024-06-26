import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:gap/gap.dart';
import 'package:open_settings/open_settings.dart';
import 'package:senang_launcher/app_list/models/app_data.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:senang_launcher/settings/views/screens/app_settings.dart';
import 'package:senang_launcher/settings/views/screens/color_settings.dart';
import 'package:senang_launcher/settings/views/screens/layout_settings.dart';
import 'package:senang_launcher/settings/views/screens/text_settings.dart';

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
    final maxHeight = MediaQuery.sizeOf(context).height * 0.65;
    final colors = Theme.of(context).colorScheme;
    return showModalBottomSheet(
      backgroundColor: colors.secondaryContainer,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: maxHeight),
      showDragHandle: false,
      enableDrag: false,
      builder: builder,
      barrierColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    return Builder(builder: (context) {
      final packageInfo =
          context.select((SettingsCubit settings) => settings.packageInfo);

      return SettingsList(
        darkTheme: settingsDarkTheme,
        lightTheme: settingsLightTheme,
        sections: [
          if (app != null)
            SettingsSection(
                title: Row(
                  children: [
                    if (app!.app! is ApplicationWithIcon) ...[
                      Image.memory(
                        (app!.app! as ApplicationWithIcon).icon,
                        width: 20,
                        height: 20,
                      ),
                      const Gap(10)
                    ],
                    Expanded(child: Text(app!.app!.appName)),
                  ],
                ),
                tiles: [
                  SettingsTile(
                    leading: const Icon(Icons.info),
                    title: Text(locals.appInfo),
                    onPressed: (context) =>
                        DeviceApps.openAppSettings(app!.app!.packageName),
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.delete),
                    title: Text(locals.uninstall),
                    onPressed: (context) =>
                        DeviceApps.uninstallApp(app!.app!.packageName),
                  ),
                  SettingsTile(
                    title: Text(locals.hideApp),
                    onPressed: (context) {
                      hideApp(app!, true);
                      Navigator.of(context).pop();
                    },
                    leading: const Icon(Icons.remove_red_eye_rounded),
                  )
                ]),
          SettingsSection(title: Text(locals.settings), tiles: [
            SettingsTile(
              leading: const Icon(Icons.apps),
              title: Text(locals.appsSettings),
              onPressed: (context) => showSettingsSheet(
                  context, (context) => const AppSettingsSheet()),
            ),
            SettingsTile(
              leading: const Icon(Icons.text_fields),
              title: Text(locals.textSettings),
              onPressed: (context) => showSettingsSheet(
                  context, (context) => const TextSettingsSheet()),
            ),
            SettingsTile(
                leading: const Icon(Icons.format_paint),
                title: Text(locals.colorSettings),
                onPressed: (context) => showSettingsSheet(
                    context, (context) => const ColorSettings())),
            SettingsTile(
                leading: const Icon(Icons.square_foot),
                title: Text(locals.layoutSettings),
                onPressed: (context) => showSettingsSheet(
                    context, (context) => const LayoutSettingsSheet())),
          ]),
          SettingsSection(title: (Text(locals.about)), tiles: [
            SettingsTile.navigation(
              leading: const Icon(Icons.approval),
              title: Text(locals.setAsDefaultLauncher),
              description: Text(locals.setAsDefaultLauncherExplanation),
              onPressed: (context) {
                OpenSettings.openManageDefaultAppsSetting();
              },
            ),
            SettingsTile(
              leading: const Icon(Icons.badge_outlined),
              title: Text('${locals.name}: ${packageInfo.appName}'),
              description:
                  Text('${locals.package}: ${packageInfo.packageName}'),
            ),
            SettingsTile(
              leading: const Icon(Icons.numbers),
              title: Text('${locals.version}: ${packageInfo.version}'),
              description: Text('${locals.build}: ${packageInfo.buildNumber}'),
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.account_balance),
              title: Text(locals.licenses),
              onPressed: (context) => showLicensePage(context: context),
            )
          ]),
        ],
      );
    });
  }
}
