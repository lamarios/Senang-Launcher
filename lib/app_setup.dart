import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/app_list/state/letter_list.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:vibration/vibration.dart';

/// sets up all the global providers and listeners
class AppSetup extends StatelessWidget {
  final Widget child;

  const AppSetup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SettingsCubit(const SettingsState())),
          BlocProvider(
            create: (context) => AppListCubit(
                const AppListState(), context.read<SettingsCubit>(),
                subscribeToStuff: true, withIcons: false)
              ..getApps(withLoading: true),
          ),
          BlocProvider(
            create: (context) => LetterListCubit(
                const LetterListState(), context.read<AppListCubit>()),
          )
        ],
        child: MultiBlocListener(listeners: [
          BlocListener<SettingsCubit, SettingsState>(
            listener: (context, state) =>
                context.read<AppListCubit>().getApps(),
            listenWhen: (previous, current) =>
                previous.dataDays != current.dataDays,
          ),
          BlocListener<AppListCubit, AppListState>(
            listenWhen: (previous, current) => previous.apps != current.apps,
            listener: (context, state) =>
                context.read<LetterListCubit>().defineLetters(state.apps),
          ),
          BlocListener<LetterListCubit, LetterListState>(
            listenWhen: (previous, current) {
              return previous.index != current.index;
            },
            listener: (context, state) async {
              if (((await Vibration.hasVibrator()) ?? false) &&
                  (await Vibration.hasAmplitudeControl() ?? false)) {
                EasyThrottle.throttle(
                    'vibration', const Duration(milliseconds: 10), () {
                  Vibration.vibrate(duration: 10, amplitude: 20);
                });
              }
            },
          )
        ], child: child));
  }
}
