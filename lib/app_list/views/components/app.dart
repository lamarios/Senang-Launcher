import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_launcher/app_list/models/app_data.dart';
import 'package:simple_launcher/app_list/state/app_list.dart';
import 'package:simple_launcher/settings/state/settings.dart';
import 'package:simple_launcher/utils/utils.dart';

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
        return (app.launchCount - c.state.minLaunches) /
            max(1, (c.state.maxLaunches - c.state.minLaunches));
      });

      final color = app.hasNotification
          ? Colors.yellow
          : Theme.of(context).brightness == Brightness.light
              ? settings.tintColor
                  ? darken(
                      colors.primary, max(1, (percentageOfMax * 100).toInt()))
                  : colors.primary
              : settings.tintColor
                  ? lighten(
                      colors.primary, max(1, (percentageOfMax * 100).toInt()))
                  : colors.primary;

      return Text(
        app.app!.appName,
        style: textTheme.bodyLarge?.copyWith(
            fontSize:
                settings.minFontSize + settings.maxFontSize * percentageOfMax,
            color: color,
            fontWeight: FontWeight.bold,
            height: settings.lineHeight),
      );
    });
  }
}
