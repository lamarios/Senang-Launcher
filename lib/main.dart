import 'package:flutter/material.dart';
import 'package:simple_launcher/db.dart';
import 'package:simple_launcher/router.dart';

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
    var brandColor = const Color(0xFF00C0A2);
    final lightTheme = ColorScheme.fromSeed(
        seedColor: brandColor, brightness: Brightness.light);
    final darkTheme = ColorScheme.fromSeed(
        seedColor: brandColor, brightness: Brightness.dark);

    return MaterialApp.router(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: lightTheme,

        useMaterial3: true,
      ),
      darkTheme: ThemeData(colorScheme: darkTheme, useMaterial3: true),
      routerConfig: _appRouter.config(),
    );
  }
}
