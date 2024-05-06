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

    return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) {
      final double percentageOfMax = context.select((AppListCubit c) {
        return c.percentageOfMax(app);
      });

      final notificationColor = context
          .select((SettingsCubit value) => value.state.notificationColor);

      final mainColor =
          context.select((SettingsCubit value) => value.state.color);

      final color = app.hasNotification
          ? notificationColor
          : Theme.of(context).brightness == Brightness.light
              ? settings.tintColor
                  ? darken(mainColor, max(1, (percentageOfMax * 100).toInt()))
                  : mainColor
              : settings.tintColor
                  ? lighten(mainColor, max(1, (percentageOfMax * 100).toInt()))
                  : mainColor;

      return
/*
        Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (settings.showAppIcons && app.app! is ApplicationWithIcon) ...[
            Image.memory((app.app! as ApplicationWithIcon).icon,
                width: settings.minFontSize +
                    settings.maxFontSize * percentageOfMax,
                height: settings.minFontSize +
                    settings.maxFontSize * percentageOfMax,
                gaplessPlayback: true),
            const Gap(10)
          ],
          if (settings.showAppNames)
*/
          Text(
        app.app!.appName,
        style: textTheme.bodyLarge?.copyWith(
            fontSize:
                settings.minFontSize + settings.maxFontSize * percentageOfMax,
            color: color,
            fontWeight: FontWeight.bold,
            height: settings.lineHeight),
      );
/*
        ],
      );
*/
    });
  }
}
