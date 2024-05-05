import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LayoutSettingsSheet extends StatelessWidget {
  const LayoutSettingsSheet({super.key});

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
          SettingsSection(title: Text(locals.layoutSettings), tiles: [
            SettingsTile.switchTile(
              title: Text(locals.showSearchBar),
              initialValue: settings.showSearch,
              onToggle: (value) =>
                  cubit.updateSetting(showSearchSettingName, value.toString()),
            ),
            SettingsTile.switchTile(
              title: Text(locals.showRightLetterList),
              initialValue: settings.showLetterList,
              onToggle: (value) => cubit.updateSetting(
                  showLetterListSettingName, value.toString()),
            ),
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
