import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:senang_launcher/settings/views/components/plus_minus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextSettingsSheet extends StatelessWidget {
  const TextSettingsSheet({super.key});

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
          SettingsSection(title: Text(locals.textSize), tiles: [
            SettingsTile(
              title: Text(locals.minimumSize),
              trailing: PlusMinus(
                value: settings.minFontSize,
                min: 1,
                max: settings.maxFontSize,
                onChanged: (newValue) => cubit.updateSetting(
                    minFontSizeSettingName, newValue.toString()),
              ),
            ),
            SettingsTile(
              title: Text(locals.maximumSize),
              trailing: PlusMinus(
                value: settings.maxFontSize,
                min: settings.minFontSize,
                onChanged: (newValue) => cubit.updateSetting(
                    maxFontSizeSettingName, newValue.toString()),
              ),
            ),
          ]),
          SettingsSection(title: Text(locals.spacing), tiles: [
            SettingsTile(
              title: Text(locals.horizontalSpacing),
              trailing: PlusMinus(
                value: settings.horizontalSpacing,
                min: 0,
                onChanged: (newValue) => cubit.updateSetting(
                    horizontalSpacingSettingName, newValue.toString()),
              ),
            ),
            SettingsTile(
              title: Text(locals.verticalSpacing),
              trailing: PlusMinus(
                value: settings.verticalSpacing,
                min: 0,
                onChanged: (newValue) => cubit.updateSetting(
                    verticalSpacingSettingName, newValue.toString()),
              ),
            )
          ])
        ],
      );
    });
  }
}
