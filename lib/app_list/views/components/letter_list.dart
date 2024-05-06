import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/app_list/state/letter_list.dart';
import 'package:senang_launcher/settings/views/screens/settings.dart';
import 'package:vibration/vibration.dart';

const double _fingerGap = 125;
const double _fingerIndexGap = 12;
// const double _letterScale = 1.75;

const settingLetterPlaceHolder = 'show-settings-instead-of-filter';

class LetterList extends StatefulWidget {
  const LetterList({super.key});

  @override
  State<LetterList> createState() => _LetterListState();
}

class _LetterListState extends State<LetterList> {
  GlobalKey key = GlobalKey();

  setIndex(BuildContext context, Offset globalPosition, List<String> letters) {
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double y = position.dy; //this is y - I think it's what you want
    final xPosition = (globalPosition.dx - position.dx);
    double percentageOfHeight = (globalPosition.dy - y) / box.size.height;
    int index = (letters.length * percentageOfHeight).toInt();
    index = min(letters.length - 1, index);
    index = max(0, index);

    context.read<LetterListCubit>().setIndex(index, letters[index], xPosition);
  }

  showSettings(BuildContext context) {
    final cubit = context.read<AppListCubit>();
    SettingsSheet.showSettingsSheet(
        context,
        (context) => SettingsSheet(
              hideApp: cubit.hideApp,
            ));

    cubit.setLetterFilter(null);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => LetterListCubit(
          const LetterListState(), context.read<AppListCubit>()),
      child: BlocListener<LetterListCubit, LetterListState>(
        listenWhen: (previous, current) => previous.index != current.index,
        listener: (context, state) async {
          if (((await Vibration.hasVibrator()) ?? false) &&
              (await Vibration.hasAmplitudeControl() ?? false)) {
            Vibration.vibrate(duration: 10, amplitude: 20);
          }
        },
        child: Builder(builder: (context) {
          final letters = context.select((AppListCubit value) {
            Set<String> letters = {};

            value.state.apps
                .where((element) => !element.hidden)
                .map((e) => e.app!.appName.substring(0, 1))
                .forEach((element) {
              letters.add(element.toUpperCase());
            });

            var letterList = letters.toList();
            letterList.sort();
            return letterList;
          });

          final hoveredIndex =
              context.select((LetterListCubit value) => value.state.index);

          final xOffset =
              context.select((LetterListCubit value) => value.state.xOffset);

          final letterCubit = context.read<LetterListCubit>();

          letters.insert(0, '○');
          letters.add(settingLetterPlaceHolder);

          final letterWidgets = <Widget>[];

          double mean = (_fingerIndexGap * 2 - 1) / 2; // Mean of the bell curve
          double deviation = mean / 3.2; // Standard deviation

          for (final (idx, l) in letters.indexed) {
            var hovered = idx == hoveredIndex;
            double offset = 0;
            // double scale = 1;

            // we do a cascade of offsets
            if (hovered) {
              offset = _fingerGap + (xOffset ?? 0);
              // scale = _letterScale;
            } else if (hoveredIndex != null &&
                (hoveredIndex - idx).abs() <= _fingerIndexGap) {
              var distance = (idx - hoveredIndex).abs();
              double bellValue =
                  1 - exp(-(pow(distance - mean, 2) / (2 * pow(deviation, 2))));

              offset = bellValue * (_fingerGap + (xOffset ?? 0));
              // scale = max(1, bellValue * _letterScale);
            }

            letterWidgets.add(Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hovered
                      ? colors.secondaryContainer
                      : colors.secondaryContainer.withOpacity(0)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 2.0, horizontal: hovered ? 4 : 0),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 100),
                  scale: 1,
                  child: SizedBox(
                    height: 15,
                    child: Center(
                      child: l == settingLetterPlaceHolder
                          ? Icon(Icons.settings,
                              size: 13,
                              color: hovered
                                  ? colors.primary
                                  : colors.onBackground)
                          : Text(
                              l,
                              style: textTheme.labelMedium?.copyWith(
                                  color: hovered
                                      ? colors.primary
                                      : colors.onBackground),
                            ),
                    ),
                  ),
                ),
              ),
            ).animate(target: offset > 0 ? 1 : 0).moveX(
                begin: 0,
                end: -offset,
                curve: Curves.easeInOutQuad,
                duration: const Duration(milliseconds: 100)));
          }

          return LayoutBuilder(builder: (context, constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragEnd: (details) {
                if (hoveredIndex == letters.length - 1) {
                  showSettings(context);
                }
                letterCubit.setIndex(null, '', null);
              },
              onVerticalDragDown: (details) =>
                  setIndex(context, details.globalPosition, letters),
              onVerticalDragUpdate: (details) =>
                  setIndex(context, details.globalPosition, letters),
              onTapUp: (details) {
                if (hoveredIndex == letters.length - 1) {
                  showSettings(context);
                }
                letterCubit.setIndex(null, '', null);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  key: key,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: letterWidgets,
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}
