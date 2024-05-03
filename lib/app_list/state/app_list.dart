// This file is "main.dart"
import 'dart:math';

import 'package:device_apps/device_apps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_launcher/db.dart';

import '../models/app_data.dart';

part 'app_list.freezed.dart';

class AppListCubit extends Cubit<AppList> {
  AppListCubit(super.initialState) {
    DeviceApps.listenToAppsChanges().listen(onAppChange);
  }
  @override
  close() async {
    super.close();
  }

  getApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true, includeSystemApps: true);

    List<AppData> appData = (await db.getAppData(apps))
        .where((element) => element.app != null)
        .toList();

    appData.sort(
      (a, b) =>
          a.app!.appName.toLowerCase().compareTo(b.app!.appName.toLowerCase()),
    );

    emit(state.copyWith(apps: appData));
    setMinMax();
  }

  setMinMax() {
    int maxLaunches = 0;
    int minLaunches = 0x7FFFFFFFFFFFFFFF;
    for (final app in state.apps) {
      maxLaunches = max(app.launchCount, maxLaunches);
      minLaunches = min(app.launchCount, minLaunches);
    }

    emit(state.copyWith(maxLaunches: maxLaunches, minLaunches: minLaunches));
  }

  increaseLaunches(AppData app) {
    List<AppData> apps = List.from(state.apps);
    int index = apps.indexOf(app);
    if (index >= 0) {
      final newApp = app.copyWith(launchCount: app.launchCount + 1);
      apps[index] = newApp;

      emit(state.copyWith(apps: apps));
      db.saveAppData(app.app!.packageName, newApp);
      setMinMax();
    }
  }

  void onAppChange(ApplicationEvent event) {
    getApps();
  }

  void setFilter(String value) {
    emit(state.copyWith(filter: value));
  }
}

@freezed
class AppList with _$AppList {
  const factory AppList(
      {@Default([]) List<AppData> apps,
      @Default(0) int maxLaunches,
      @Default('') String filter,
      @Default(0) minLaunches}) = _AppList;
}
