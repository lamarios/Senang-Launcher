import 'package:auto_route/auto_route.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:senang_launcher/db.dart';
import 'package:senang_launcher/router.dart';
import 'package:senang_launcher/settings/state/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await db.setUpDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(const SettingsState()),
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

          return MaterialApp.router(
            title: 'Senang Launcher',
            themeMode: theme,
            theme: ThemeData(
              colorScheme: lightTheme,
              useMaterial3: true,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            darkTheme: ThemeData(colorScheme: darkTheme, useMaterial3: true),
            routerConfig: _appRouter.config(),
          );
        });
      }),
    );
  }
}
