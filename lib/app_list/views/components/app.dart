import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senang_launcher/app_list/models/app_data.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:senang_launcher/utils/utils.dart';

// const List<double> _brackets = [0, 0.25, 0.5, 0.75, 1];

class App extends StatelessWidget {
  final AppData app;

  const App({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
      final double percentageOfMax = context.select((AppListCubit c) {
        return c.percentageOfMax(app);
      });

      final mainColor =
          settings.dynamicColors ? colors.primary : settings.color;

      final color = app.hasNotification
          ? settings.notificationColor
          : Theme.of(context).brightness == Brightness.light
              ? settings.tintColor
                  ? darken(mainColor, max(1, (percentageOfMax * 100).toInt()))
                  : mainColor
              : settings.tintColor
                  ? lighten(mainColor, max(1, (percentageOfMax * 100).toInt()))
                  : mainColor;

      var fontSize = min(
          settings.maxFontSize,
          settings.minFontSize +
              ((settings.maxFontSize - settings.minFontSize) *
                  percentageOfMax));

      print('${app.app!.appName} $fontSize  ${settings.maxFontSize}');
      return Text(
        app.app!.appName,
        textAlign: settings.listStyle.textAlign,
        style: textTheme.bodyLarge?.copyWith(
            fontSize: fontSize,
            color: color,
            fontWeight: FontWeight.bold,
            height: settings.lineHeight),
      );
    });
  }
}
