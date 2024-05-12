import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:senang_launcher/app_setup.dart';
import 'package:senang_launcher/db.dart';
import 'package:senang_launcher/router.dart';
import 'package:senang_launcher/settings/state/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await db.setUpDb();
  final settings = SettingsCubit(const SettingsState());

  await settings.getSettings();
  runApp(MyApp(
    settingsCubit: settings,
  ));
}

class MyApp extends StatelessWidget {
  final SettingsCubit settingsCubit;
  late final _appRouter =
      AppRouter(firstLaunch: settingsCubit.state.firstLaunch);

  MyApp({super.key, required this.settingsCubit});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppSetup(
      settingsCubit: settingsCubit,
      child: Builder(builder: (context) {
        final brandColor =
            context.select((SettingsCubit value) => value.state.color);

        final dynamicColors =
            context.select((SettingsCubit value) => value.state.dynamicColors);

        final blackBackground = context
            .select((SettingsCubit value) => value.state.blackBackground);

        final theme = context.select(
            (SettingsCubit value) => value.state.themeMode ?? ThemeMode.system);

        return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
          final lightTheme = dynamicColors && lightDynamic != null
              ? lightDynamic.harmonized()
              : ColorScheme.fromSeed(
                  seedColor: brandColor, brightness: Brightness.light);
          final darkTheme = dynamicColors && darkDynamic != null
              ? darkDynamic
                  .harmonized()
                  .copyWith(background: blackBackground ? Colors.black : null)
              : ColorScheme.fromSeed(
                  seedColor: brandColor,
                  brightness: Brightness.dark,
                  background: blackBackground ? Colors.black : null);

          const appBarTheme = AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
          );

          return MaterialApp.router(
            title: 'Senang Launcher',
            themeMode: theme,
            theme: ThemeData(
              appBarTheme:
                  appBarTheme.copyWith(backgroundColor: lightTheme.background),
              colorScheme: lightTheme,
              useMaterial3: true,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            darkTheme: ThemeData(
                colorScheme: darkTheme,
                useMaterial3: true,
                appBarTheme: appBarTheme.copyWith(
                    backgroundColor: darkTheme.background)),
            routerConfig: _appRouter.config(),
          );
        });
      }),
    );
  }
}
