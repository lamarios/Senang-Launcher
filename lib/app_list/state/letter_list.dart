// This file is "main.dart"
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:senang_launcher/app_list/models/app_data.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/app_list/views/components/letter_list.dart';

part 'letter_list.freezed.dart';

class LetterListCubit extends Cubit<LetterListState> {
  final AppListCubit appListCubit;

  LetterListCubit(super.initialState, this.appListCubit);

  setIndex(double? rawIndex, double? xOffset, {bool fromInvisible = false}) {
    int? index;
    if (rawIndex != null) {
      index = min(state.letters.length - 1, rawIndex.toInt());
      index = max(0, index);
    }

    emit(state.copyWith(
        rawIndex: rawIndex,
        index: index,
        xOffset: xOffset?.abs(),
        fromInvisible: fromInvisible));
    if (index != null) {
      appListCubit.setLetterFilter(index == 0 ? null : state.letters[index]);
    }
  }

  defineLetters(List<AppData> apps) {
    Set<String> letters = {};

    apps
        .where((element) => !element.hidden)
        .map((e) => e.app!.appName.substring(0, 1))
        .forEach((element) {
      letters.add(element.toUpperCase());
    });

    var letterList = letters.toList();
    letterList.sort();
    letterList.insert(0, allApps);
    letterList.add(settingLetterPlaceHolder);
    emit(state.copyWith(letters: letterList));
  }
}

@freezed
class LetterListState with _$LetterListState {
  const factory LetterListState(
      {int? index,
      double? rawIndex,
      double? xOffset,
      @Default([]) List<String> letters,
      @Default(false) bool fromInvisible}) = _LetterListState;
}
