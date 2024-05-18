// This file is "main.dart"
import 'dart:async';
import 'dart:math';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notification_listener_service/notification_event.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
import 'package:senang_launcher/db.dart';
import 'package:senang_launcher/settings/state/settings.dart';

import '../models/app_data.dart';

part 'app_list.freezed.dart';

class AppListCubit extends Cubit<AppListState> {
  final bool withIcons;
  final bool getHidden;
  StreamSubscription<ServiceNotificationEvent>? notificationSubscription;
  StreamSubscription<ApplicationEvent>? appListener;
  final TextEditingController searchController = TextEditingController();
  final SettingsCubit settingsCubit;

  AppListCubit(super.initialState, this.settingsCubit,
      {this.withIcons = false,
      bool subscribeToStuff = false,
      this.getHidden = false}) {
    if (subscribeToStuff) {
      appListener = DeviceApps.listenToAppsChanges().listen(onAppChange);
      setUpNotificationListener();
    }
  }

  @override
  close() async {
    searchController.dispose();
    notificationSubscription?.cancel();
    appListener?.cancel();
    super.close();
  }

  setUpNotificationListener() async {
    if (settingsCubit.state.colorOnNotifications) {
      final bool allowed =
          await NotificationListenerService.isPermissionGranted();

      if (!allowed) {
        final bool status =
            await NotificationListenerService.requestPermission();

        if (!status) {
          return;
        }
      }

      /// stream the incoming notification events
      notificationSubscription = NotificationListenerService.notificationsStream
          .listen(onNotification);
    }
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

    final firstLetter =
        appData[index].app!.appName.substring(0, 1).toLowerCase();
    Map<String, List<AppData>> letterMap = Map.from(state.appsByLetter);

    final mapIndex = letterMap[firstLetter]?.indexWhere((element) =>
            element.app?.packageName == notification.packageName) ??
        -1;
    if (mapIndex >= 0) {
      letterMap[firstLetter]?[mapIndex] = appData[index];
    }

    emit(state.copyWith(apps: appData, appsByLetter: letterMap));
  }

  getApps({bool withLoading = false}) async {
    emit(state.copyWith(loading: withLoading));
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true,
        includeAppIcons: withIcons);

    List<AppData> appData = (await db.getAppData(
            apps: apps,
            since: DateTime.now()
                .add(Duration(days: -(settingsCubit.state.dataDays)))))
        // we remove hidden apps
        .where(
            (element) => element.app != null && (getHidden || !element.hidden))
        .toList();

    appData.sort(
      (a, b) =>
          a.app!.appName.toLowerCase().compareTo(b.app!.appName.toLowerCase()),
    );

    Map<String, List<AppData>> appsByLetter = {};
    // restore notifications values
    for (int i = 0; i < appData.length; i++) {
      final app = appData[i];
      final hasNotifications = state.apps.any((element) =>
          element.app!.packageName == app.app!.packageName &&
          element.hasNotification);
      if (hasNotifications) {
        appData[i] = app.copyWith(hasNotification: true);
      }

      final firstLetter = app.app!.appName.substring(0, 1).toLowerCase();
      appsByLetter[firstLetter] ??= [];
      appsByLetter[firstLetter]?.add(appData[i]);
    }

    emit(state.copyWith(
        apps: appData, loading: false, appsByLetter: appsByLetter));
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
    emit(state.copyWith(filter: value.trim().toLowerCase()));
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
    searchController.text = '';
    if (letter == null) {
      emit(state.copyWith(filter: '', isLetterFilter: false));
    } else {
      emit(state.copyWith(filter: letter.toLowerCase(), isLetterFilter: true));
    }
  }

  resetStats() async {
    await db.resetLaunches();
    getApps();
  }

  setShowingSettings(bool settings) {
    print('showing settings $settings');
    emit(state.copyWith(showingSettings: settings));
  }
}

@freezed
class AppListState with _$AppListState {
  const factory AppListState(
      {@Default([]) List<AppData> apps,
      // we sacrifice a bit of memory for the sake of runtime performance as it's crucial
      // for a launcher to feel smooth at all times
      @Default({}) Map<String, List<AppData>> appsByLetter,
      @Default(0) int maxLaunches,
      @Default('') String filter,
      @Default(false) bool showingSettings,
      @Default(false) bool loading,
      @Default(false) bool isLetterFilter,
      @Default(0) minLaunches}) = _AppListState;

  const AppListState._();

  List<AppData> get appropriateApps {
    if (isLetterFilter) {
      return appsByLetter[filter] ?? [];
    } else if (filter.isNotEmpty) {
      return apps
          .where(
              (element) => element.app!.appName.toLowerCase().contains(filter))
          .toList();
    } else {
      return apps;
    }
  }
}
