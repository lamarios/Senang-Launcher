import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_launcher/db.dart';
import 'package:simple_launcher/router.dart';
import 'package:simple_launcher/settings/state/settings.dart';

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
        var brandColor =
            context.select((SettingsCubit value) => value.state.color);

        final lightTheme = ColorScheme.fromSeed(
            seedColor: brandColor, brightness: Brightness.light);
        final darkTheme = ColorScheme.fromSeed(
            seedColor: brandColor, brightness: Brightness.dark);

        return MaterialApp.router(
          title: 'Flutter Demo',
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: lightTheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(colorScheme: darkTheme, useMaterial3: true),
          routerConfig: _appRouter.config(),
        );
      }),
    );
  }
}
