// This file is "main.dart"
import 'dart:async';
import 'dart:math';

import 'package:device_apps/device_apps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notification_listener_service/notification_event.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
import 'package:senang_launcher/db.dart';
import 'package:senang_launcher/settings/state/settings.dart';

import '../models/app_data.dart';

part 'app_list.freezed.dart';

class AppListCubit extends Cubit<AppListState> {
  StreamSubscription<ServiceNotificationEvent>? notificationSubscription;
  final SettingsCubit settingsCubit;

  AppListCubit(super.initialState, this.settingsCubit) {
    DeviceApps.listenToAppsChanges().listen(onAppChange);
    setUpNotificationListener();
  }

  @override
  close() async {
    notificationSubscription?.cancel();
    super.close();
  }

  setUpNotificationListener() async {
    /// check if notification permession is enebaled
    final bool allowed =
        await NotificationListenerService.isPermissionGranted();

    if (!allowed) {
      /// request notification permission
      /// it will open the notifications settings page and return `true` once the permission granted.
      final bool status = await NotificationListenerService.requestPermission();

      if (!status) {
        return;
      }
    }

    /// stream the incoming notification events
    notificationSubscription =
        NotificationListenerService.notificationsStream.listen(onNotification);
  }

  double percentageOfMax(AppData app) {
    return (app.launchCount - state.minLaunches) /
        max(1, (state.maxLaunches - state.minLaunches));
  }

  onNotification(ServiceNotificationEvent notification) {
    List<AppData> appData = List.from(state.apps);

    int index = appData.indexWhere(
        (element) => element.app?.packageName == notification.packageName);

    appData[index] = appData[index]
        .copyWith(hasNotification: !(notification.hasRemoved ?? false));
    emit(state.copyWith(apps: appData));
  }

  getApps() async {
    emit(state.copyWith(loading: true));
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true,
        includeAppIcons: true);

    List<AppData> appData = (await db.getAppData(
            apps: apps,
            since: DateTime.now()
                .add(Duration(days: -(settingsCubit.state.dataDays)))))
        .where((element) => element.app != null)
        .toList();

    appData.sort(
      (a, b) =>
          a.app!.appName.toLowerCase().compareTo(b.app!.appName.toLowerCase()),
    );

    // restore notifications values
    for (int i = 0; i < appData.length; i++) {
      final app = appData[i];
      final hasNotifications = state.apps.any((element) =>
          element.app!.packageName == app.app!.packageName &&
          element.hasNotification);
      if (hasNotifications) {
        appData[i] = app.copyWith(hasNotification: true);
      }
    }

    emit(state.copyWith(apps: appData, loading: false));
    setMinMax();
  }

  setMinMax() {
    int maxLaunches = 0;
    int minLaunches = 0x7FFFFFFFFFFFFFFF;
    for (final app in state.apps) {
      if (!app.hidden) {
        maxLaunches = max(app.launchCount, maxLaunches);
        minLaunches = min(app.launchCount, minLaunches);
      }
    }

    emit(state.copyWith(maxLaunches: maxLaunches, minLaunches: minLaunches));
  }

  increaseLaunches(AppData app) async {
    List<AppData> apps = List.from(state.apps);
    int index = apps.indexOf(app);
    if (index >= 0) {
      await db.addLaunch(app.app!.packageName);
      getApps();
    }
  }

  void onAppChange(ApplicationEvent event) {
    getApps();
  }

  void setFilter(String value) {
    emit(state.copyWith(filter: value));
  }

  Future<void> hideApp(AppData app, bool? value) async {
    List<AppData> apps = List.from(state.apps);
    int index = apps.indexOf(app);
    if (index >= 0) {
      apps[index] = app.copyWith(hidden: value ?? false);
      await db.updateApp(apps[index]);
      emit(state.copyWith(apps: apps));
    }
  }

  void setLetterFilter(String? letter) {
    if (letter == null) {
      emit(state.copyWith(filter: '', isLetterFilter: false));
    } else {
      emit(state.copyWith(filter: letter, isLetterFilter: true));
    }
  }

  resetStats() async {
    await db.resetLaunches();
    getApps();
  }
}

@freezed
class AppListState with _$AppListState {
  const factory AppListState(
      {@Default([]) List<AppData> apps,
      @Default(0) int maxLaunches,
      @Default('') String filter,
      @Default(false) bool loading,
      @Default(false) bool isLetterFilter,
      @Default(0) minLaunches}) = _AppListState;
}
