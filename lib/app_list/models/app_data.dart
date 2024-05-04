// This file is "main.dart"
import 'package:device_apps/device_apps.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_data.freezed.dart';

part 'app_data.g.dart';

@freezed
class AppData with _$AppData {
  const factory AppData({
    @Default(false) bool hidden,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(0)
    int launchCount,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool hasNotification,
    @JsonKey(includeFromJson: false, includeToJson: false) Application? app,
  }) = _AppData;

  factory AppData.fromJson(Map<String, Object?> json) =>
      _$AppDataFromJson(json);
}
