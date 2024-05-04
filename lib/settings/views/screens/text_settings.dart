import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:senang_launcher/settings/views/components/plus_minus.dart';

class TextSettingsSheet extends StatelessWidget {
  const TextSettingsSheet({super.key});

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
          SettingsSection(title: const Text('Text size'), tiles: [
            SettingsTile(
              title: const Text('Minimum size'),
              trailing: PlusMinus(
                value: settings.minFontSize,
                min: 1,
                max: settings.maxFontSize,
                onChanged: (newValue) => cubit.updateSetting(
                    minFontSizeSettingName, newValue.toString()),
              ),
            ),
            SettingsTile(
              title: const Text('Maximum size'),
              trailing: PlusMinus(
                value: settings.maxFontSize,
                min: settings.minFontSize,
                onChanged: (newValue) => cubit.updateSetting(
                    maxFontSizeSettingName, newValue.toString()),
              ),
            ),
            SettingsTile(
              title: const Text('Line height'),
              trailing: PlusMinus(
                value: settings.lineHeight,
                step: 0.1,
                onChanged: (newValue) => cubit.updateSetting(
                    lineHeightSettingName, newValue.toString()),
              ),
            ),
          ]),
          SettingsSection(title: const Text('Spacing'), tiles: [
            SettingsTile(
              title: const Text('Horizontal spacing'),
              trailing: PlusMinus(
                value: settings.horizontalSpacing,
                min: 0,
                onChanged: (newValue) => cubit.updateSetting(
                    horizontalSpacingSettingName, newValue.toString()),
              ),
            ),
            SettingsTile(
              title: const Text('Vertical spacing'),
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
