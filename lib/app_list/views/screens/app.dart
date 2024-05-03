import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_launcher/app_list/models/app_data.dart';
import 'package:simple_launcher/app_list/state/app_list.dart';
import 'package:simple_launcher/utils/utils.dart';

// const List<double> _brackets = [0, 0.25, 0.5, 0.75, 1];

class App extends StatelessWidget {
  final AppData app;

  const App({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Builder(builder: (context) {
      final double percentageOfMax = context.select((AppListCubit c) {
        return (app.launchCount - c.state.minLaunches) /
            (c.state.maxLaunches - c.state.minLaunches);
/*
        if(percentage == 0){
          return 0;
        }

        if(percentage == 1){
          return 1;
        }
        // we find which bracket we belong to
        for (final (idx, bracket) in _brackets.indexed) {
          if (bracket == 1 || idx == _brackets.length - 1) {
            return 1;
          }

          if (percentage < _brackets[idx + 1]) {
            return _brackets[idx + 1];
          }
        }

        return 0;
*/
      });

      final color = Theme.of(context).brightness == Brightness.light
          ? darken(colors.primary, max(1, (percentageOfMax * 100).toInt()))
          : lighten(colors.primary, max(1, (percentageOfMax * 100).toInt()));

      return Text(
        '${app.app!.appName}',
        style: textTheme.bodyLarge?.copyWith(
            fontSize: 20 + 50 * percentageOfMax,
            color: color,
            fontWeight: FontWeight.bold,
            height: 1),
      );
    });
  }
}
