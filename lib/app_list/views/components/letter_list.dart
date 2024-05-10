import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/app_list/state/letter_list.dart';
import 'package:senang_launcher/settings/views/screens/settings.dart';

const double _fingerGap = 125;
const double _fingerIndexGap = 12;
const double _letterYStagger = 7;
// const double _letterScale = 1.75;

const settingLetterPlaceHolder = 'show-settings-instead-of-filter';
const allApps = 'all-apps';

class LetterList extends StatefulWidget {
  final bool rightMode;
  final bool invisible;

  const LetterList({super.key, this.rightMode = true, this.invisible = false});

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

    context.read<LetterListCubit>().setIndex(index, letters[index], xPosition,
        fromInvisible: widget.invisible);
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

    return BlocBuilder<LetterListCubit, LetterListState>(
        builder: (context, state) {
      final letterCubit = context.read<LetterListCubit>();

      final letterWidgets = <Widget>[];

      double mean = (_fingerIndexGap * 2 - 1) / 2; // Mean of the bell curve
      double deviation = mean / 3.2; // Standard deviation

      for (final (idx, l) in state.letters.indexed) {
        var hovered = idx == state.index;
        double offset = 0;
        double scale = 1;
        double yOffset = 0;

        if (!widget.invisible) {
          if (state.index != null &&
              idx > state.index! &&
              idx <= state.index! + _letterYStagger) {
            yOffset += _letterYStagger * (1 / (idx - state.index!).abs());
          }

          if (state.index != null &&
              idx < state.index! &&
              idx >= state.index! - _letterYStagger) {
            yOffset -= _letterYStagger * (1 / (idx - state.index!).abs());
          }

          // we do a cascade of offsets
          if (hovered) {
            scale = 3;
          }
          if (state.index != null &&
              (state.index! - idx).abs() <= _fingerIndexGap) {
            var distance = (idx - state.index!).abs();
            double bellValue =
                1 - exp(-(pow(distance - mean, 2) / (2 * pow(deviation, 2))));

            if (state.fromInvisible) {
              offset = bellValue * 30;
            } else {
              offset = bellValue * (_fingerGap + (state.xOffset ?? 0));
            }
            // scale = max(1, bellValue * _letterScale);
          }

          if (!widget.rightMode) {
            offset = -offset;
          }
        }

        letterWidgets.add(Transform.translate(
          offset: Offset(-offset, yOffset),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 2.0, horizontal: hovered ? 4 : 0),
            child: Transform.scale(
              scale: scale,
              child: SizedBox(
                height: 17,
                width: 17,
                child: widget.invisible
                    ? null
                    : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hovered
                                ? colors.secondaryContainer
                                : colors.secondaryContainer.withOpacity(0)),
                        child: Center(
                          child: l == allApps
                              ? Icon(Icons.apps,
                                  size: 13,
                                  color: hovered
                                      ? colors.primary
                                      : colors.onBackground)
                              : l == settingLetterPlaceHolder
                                  ? Icon(Icons.settings,
                                      size: 13,
                                      color: hovered
                                          ? colors.primary
                                          : colors.onBackground)
                                  : Text(
                                      l,
                                      style: textTheme.labelMedium?.copyWith(
                                          fontSize: 14,
                                          color: hovered
                                              ? colors.primary
                                              : colors.onBackground),
                                    ),
                        ),
                      ),
              ),
            ),
          ),
        ));
      }

      return SizedBox(
        width: 30,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragEnd: (details) {
              if (state.index == state.letters.length - 1) {
                showSettings(context);
              }
              letterCubit.setIndex(null, '', null);
            },
            onLongPress: () {},
            onLongPressCancel: () {},
            onLongPressEnd: (details) {
              if (state.index == state.letters.length - 1) {
                showSettings(context);
              }
              letterCubit.setIndex(null, '', null);
            },
            onLongPressMoveUpdate: (details) =>
                setIndex(context, details.globalPosition, state.letters),
            onVerticalDragDown: (details) =>
                setIndex(context, details.globalPosition, state.letters),
            onVerticalDragUpdate: (details) =>
                setIndex(context, details.globalPosition, state.letters),
            onTapUp: (details) {
              if (state.index == state.letters.length - 1) {
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
          ),
        ),
      );
    });
  }
}
