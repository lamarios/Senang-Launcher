import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:simple_launcher/app_list/models/app_data.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

DbClient db = DbClient();

class DbClient {
  late final Database db;

  final appData = stringMapStoreFactory.store('app-data');
  final appLaunches = StoreRef<int, String>('app-launches');
  final settings = StoreRef<String, String>('settings');

  Future<void> setUpDb() async {
    late final Directory docsDir;
    try {
      docsDir = await getApplicationDocumentsDirectory();
    } catch (e) {
      docsDir = Directory.current;
    }

    var dbPath = p.join(docsDir.path, "app.db");

    final databaseFactorySqflite =
        getDatabaseFactorySqflite(sqflite.databaseFactory);
    db = await databaseFactorySqflite.openDatabase(
      dbPath.toString(),
      version: 1,
    );
  }

  Future<Map<String, String>> getSettings() async {
    final records = await settings.find(db);
    Map<String, String> map = {};
    for (final r in records) {
      map[r.key] = r.value;
    }
    return map;
  }

  Future<void> updateSetting(String name, String value) async {
    await settings.record(name).put(db, value);
  }

  Future<void> addLaunch(String appPackage) async {
    await appLaunches
        .record(DateTime.now().millisecondsSinceEpoch)
        .put(db, appPackage);
  }

  Future<Map<String, int>> getLaunchCountByApp(DateTime since) async {
    final records = await appLaunches.find(db,
        finder: Finder(
            filter:
                Filter.greaterThan(Field.key, since.millisecondsSinceEpoch)));
    Map<String, int> launches = {};

    for (final r in records) {
      launches[r.value] ??= 0;
      launches[r.value] = launches[r.value]! + 1;
    }

    return launches;
  }

  Future<List<AppData>> getAppData(
      {required List<Application> apps, required DateTime since}) async {
    final launches = await getLaunchCountByApp(since);
    var records = await appData.find(db);
    return apps
        .map((app) =>
            records
                .where((element) => element.key == app.packageName)
                .map((e) => AppData.fromJson(e.value)
                    .copyWith(app: app, launchCount: launches[e.key] ?? 0))
                .firstOrNull ??
            AppData(app: app, launchCount: launches[app.packageName] ?? 0))
        .toList();
  }

  Future<void> saveAppData(String packageName, AppData newApp) async {
    await appData.record(packageName).put(db, newApp.toJson());
  }

  Future<void> updateApp(AppData app) async {
    appData.record(app.app?.packageName ?? '').put(db, app.toJson());
  }
}
