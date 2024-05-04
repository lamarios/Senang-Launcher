// This file is "main.dart"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:senang_launcher/db.dart';

part 'settings.freezed.dart';

const dataDaysSettingName = 'data-days';
const horizontalSpacingSettingName = 'horizontal-spacing';
const verticalSpacingSettingName = 'vertical-spacing';
const minFontSizeSettingName = 'min-font-size';
const maxFontSizeSettingName = 'max-font-size';
const lineHeightSettingName = 'line-height';
const tintColorSettingName = 'tint-color';
const colorSettingName = 'color';
const colorOnNotificationSettingName = 'color-on-notification';
const notificationColorSettingName = 'notification-color';
const showSearchSettingName = 'show-search';
const showLetterListSettingName = 'show-letter-list';
const showWallPaperSettingName = 'show-wallpaper';

const wallPaperDimSettingName = 'wall-paper-dim';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(super.initialState) {
    getSettings();
  }

  getSettings() async {
    final settings = await db.getSettings();
    emit(state.copyWith(settings: settings));
  }

  updateSetting(String name, String value) async {
    await db.updateSetting(name, value);
    getSettings();
  }
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({@Default({}) Map<String, String> settings}) =
      _SettingsState;

  const SettingsState._();

  int get dataDays => int.tryParse(settings[dataDaysSettingName] ?? '30') ?? 30;

  double get horizontalSpacing =>
      double.tryParse(settings[horizontalSpacingSettingName] ?? '25') ?? 15;

  double get verticalSpacing =>
      double.tryParse(settings[verticalSpacingSettingName] ?? '0') ?? 0;

  double get minFontSize =>
      double.tryParse(settings[minFontSizeSettingName] ?? '20') ?? 20;

  double get maxFontSize =>
      double.tryParse(settings[maxFontSizeSettingName] ?? '50') ?? 50;

  double get lineHeight =>
      double.tryParse(settings[lineHeightSettingName] ?? '1') ?? 1;

  Color get color => Color(
      int.tryParse(settings[colorSettingName] ?? '0xFF00C0A2') ?? 0xFF00C0A2);

  bool get tintColor =>
      bool.tryParse(settings[tintColorSettingName] ?? 'true') ?? true;

  Color get notificationColor => Color(
      int.tryParse(settings[colorOnNotificationSettingName] ?? '0xFFFFEB3B') ??
          Colors.yellow.value);

  bool get colorOnNotifications =>
      bool.tryParse(settings[colorOnNotificationSettingName] ?? 'true') ?? true;

  bool get showSearch =>
      bool.tryParse(settings[showSearchSettingName] ?? 'true') ?? true;

  bool get showWallPaper =>
      bool.tryParse(settings[showWallPaperSettingName] ?? 'false') ?? false;

  double get wallPaperDim =>
      double.tryParse(settings[wallPaperDimSettingName] ?? '0.5') ?? 0.5;

  bool get showLetterList =>
      bool.tryParse(settings[showLetterListSettingName] ?? 'true') ?? true;
}
