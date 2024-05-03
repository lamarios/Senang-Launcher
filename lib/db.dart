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

  Future<List<AppData>> getAppData(List<Application> apps) async {
    var records = await appData.find(db);
    return apps
        .map((app) =>
            records
                .where((element) => element.key == app.packageName)
                .map((e) => AppData.fromJson(e.value).copyWith(app: app))
                .firstOrNull ??
            AppData(app: app))
        .toList();
  }

  Future<void> saveAppData(String packageName, AppData newApp) async {
    await appData.record(packageName).put(db, newApp.toJson());
  }
}
