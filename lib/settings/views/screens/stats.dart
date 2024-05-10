import 'package:auto_route/auto_route.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:senang_launcher/app_list/models/app_data.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/settings/state/settings.dart';

@RoutePage()
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => AppListCubit(
          const AppListState(), context.read<SettingsCubit>(),
          withIcons: true, getHidden: true)
        ..getApps(withLoading: true),
      child: Scaffold(
          appBar: AppBar(
            title: Text(locals.appsStats),
            actions: [
              Builder(builder: (context) {
                return TextButton(
                    onPressed: () => context.read<AppListCubit>().resetStats(),
                    child: Text(locals.resetStats));
              })
            ],
          ),
          body: SafeArea(
            bottom: false,
            child: BlocBuilder<AppListCubit, AppListState>(
              builder: (context, state) {
                final daysStats = context
                    .select((SettingsCubit value) => value.state.dataDays);

                List<AppData> data = List.from(state.apps);
                data.sort(
                  (a, b) => b.launchCount.compareTo(a.launchCount),
                );

                return state.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Text(
                              'Since ${DateFormat.yMMMd().format(DateTime.now().add(Duration(days: -daysStats)))}'),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final app = data[index];
                                return Padding(
                                  key: ValueKey(app),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          if (app.app!
                                              is ApplicationWithIcon) ...[
                                            Image.memory(
                                                (app.app!
                                                        as ApplicationWithIcon)
                                                    .icon,
                                                width: 20,
                                                height: 20,
                                                gaplessPlayback: true),
                                            const Gap(10)
                                          ],
                                          Expanded(
                                              child: Text(app.app!.appName)),
                                        ],
                                      ),
                                      const Gap(5),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: colors.secondaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: FractionallySizedBox(
                                          widthFactor: state.maxLaunches > 0
                                              ? app.launchCount /
                                                  state.maxLaunches
                                              : 0,
                                          heightFactor: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: colors
                                                    .onSecondaryContainer),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${app.launchCount} launches',
                                            style: textTheme.labelSmall
                                                ?.copyWith(
                                                    color: colors.secondary),
                                          ))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
              },
            ),
          )),
    );
  }
}
