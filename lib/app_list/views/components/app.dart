import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senang_launcher/app_list/models/app_data.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:senang_launcher/utils/utils.dart';

class App extends StatelessWidget {
  final AppData app;

  const App({super.key, required this.app});

  Color getColor(BuildContext context,
      {required SettingsState settings,
      required double percentageOfMax,
      required ColorScheme colors}) {
    final mainColor = settings.dynamicColors ? colors.primary : settings.color;

    if (app.hasNotification && settings.colorOnNotifications) {
      return settings.notificationColor;
    }
    final brightness = Theme.of(context).brightness;

    if (!settings.tintColor) {
      return settings.invertTint
          ? tintColor(mainColor, brightness, 1)
          : mainColor;
    } else if (settings.invertTint) {
      return tintColor(mainColor, brightness, 1 - percentageOfMax);
    } else {
      return tintColor(mainColor, brightness, percentageOfMax);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
      final double percentageOfMax = context.select((AppListCubit c) {
        return c.percentageOfMax(app);
      });

      final color = getColor(context,
          settings: settings, percentageOfMax: percentageOfMax, colors: colors);

      var fontSize = min(
          settings.maxFontSize,
          settings.minFontSize +
              ((settings.maxFontSize - settings.minFontSize) *
                  percentageOfMax));

      return Text(
        app.app!.appName,
        textAlign: settings.listStyle.textAlign,
        style: textTheme.bodyLarge?.copyWith(
            fontSize: fontSize,
            color: color,
            fontWeight: FontWeight.bold,
            height: 1),
      );
    });
  }
}
