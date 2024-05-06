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

        final blackBackground = context
            .select((SettingsCubit value) => value.state.blackBackground);

        final theme = context.select(
            (SettingsCubit value) => value.state.themeMode ?? ThemeMode.system);

        final lightTheme = ColorScheme.fromSeed(
            seedColor: brandColor, brightness: Brightness.light);
        final darkTheme = ColorScheme.fromSeed(
            seedColor: brandColor,
            brightness: Brightness.dark,
            background: blackBackground ? Colors.black : null);

        return MaterialApp.router(
          title: 'Flutter Demo',
          themeMode: theme,
          theme: ThemeData(
            colorScheme: lightTheme,
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          darkTheme: ThemeData(colorScheme: darkTheme, useMaterial3: true),
          routerConfig: _appRouter.config(),
        );
      }),
    );
  }
}
