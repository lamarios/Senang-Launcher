import 'dart:ui';

import 'package:access_wallpaper/access_wallpaper.dart';
import 'package:auto_route/annotations.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/app_list/views/components/app.dart';
import 'package:senang_launcher/app_list/views/components/letter_list.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:senang_launcher/settings/views/screens/settings.dart';
import 'package:senang_launcher/utils/views/components/conditional_wrap.dart';

@RoutePage()
class AppListScreen extends StatefulWidget {
  const AppListScreen({super.key});

  @override
  State<AppListScreen> createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocProvider(
            create: (context) => AppListCubit(
                const AppListState(), context.read<SettingsCubit>())
              ..getApps(withLoading: true),
            child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settings) {
                final apps = context.select((AppListCubit value) =>
                    value.state.apps.where((element) => !element.hidden));
                final showSearch = context.select(
                    (SettingsCubit settings) => settings.state.showSearch);
                final showLetterList = context.select(
                    (SettingsCubit settings) => settings.state.showLetterList);
                final showWallpaper = context.select(
                    (SettingsCubit settings) => settings.state.showWallPaper);
                final wallpaperDim = context.select(
                    (SettingsCubit settings) => settings.state.wallPaperDim);

                final wallpaperBlur = context.select(
                    (SettingsCubit settings) => settings.state.wallpaperBlur);

                final listStyle = context.select(
                    (SettingsCubit settings) => settings.state.listStyle);

                final isLetterFilter = context
                    .select((AppListCubit value) => value.state.isLetterFilter);
                final loading =
                    context.select((AppListCubit value) => value.state.loading);
                final filter =
                    context.select((AppListCubit value) => value.state.filter);

                final cubit = context.read<AppListCubit>();
                final appsWidget = apps
                    .where((element) {
                      if (isLetterFilter) {
                        return element.app!.appName
                            .toLowerCase()
                            .startsWith(filter.toLowerCase());
                      } else {
                        return element.app!.appName
                            .toLowerCase()
                            .contains(filter.toLowerCase());
                      }
                    })
                    .map((e) => GestureDetector(
                        onLongPress: () => SettingsSheet.showSettingsSheet(
                            context,
                            (context) => SettingsSheet(
                                  hideApp: cubit.hideApp,
                                  app: e,
                                )).then((value) => cubit.getApps()),
                        onTap: () {
                          if (!kDebugMode) {
                            DeviceApps.openApp(e.app!.packageName);
                          }
                          cubit.increaseLaunches(e);
                          cubit.setFilter('');
                          searchController.text = '';
                        },
                        child: App(key: ValueKey(e.app!.packageName), app: e)))
                    .toList();
                return BlocListener<SettingsCubit, SettingsState>(
                  listener: (context, state) => cubit.getApps(),
                  listenWhen: (previous, current) =>
                      previous.dataDays != current.dataDays,
                  child: Stack(
                    children: [
                      if (showWallpaper)
                        Positioned.fill(
                          child: FutureBuilder<Uint8List?>(
                            future: AccessWallpaper()
                                .getWallpaper(AccessWallpaper.homeScreenFlag),
                            builder: (context, snapshot) {
                              return snapshot.hasData && snapshot.data != null
                                  ? Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                      gaplessPlayback: true,
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      if (showWallpaper)
                        Positioned.fill(
                            child: ConditionalWrap(
                          wrapIf: wallpaperBlur > 0,
                          wrapper: (child) => BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: wallpaperBlur, sigmaY: wallpaperBlur),
                            child: child,
                          ),
                          child: Container(
                            color: colors.background.withOpacity(wallpaperDim),
                          ),
                        )),
                      loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 58),
                              child: GestureDetector(
                                onLongPress: () =>
                                    SettingsSheet.showSettingsSheet(
                                        context,
                                        (context) => SettingsSheet(
                                              hideApp: cubit.hideApp,
                                            )).then((value) => cubit.getApps()),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Center(
                                                  child: isLetterFilter &&
                                                          filter ==
                                                              settingLetterPlaceHolder
                                                      ? Text(
                                                          locals
                                                              .releaseToOpenSettings,
                                                          style: textTheme
                                                              .displayMedium
                                                              ?.copyWith(
                                                                  color: colors
                                                                      .primary),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      : listStyle.wrapApps(
                                                          context,
                                                          appsWidget,
                                                          settings
                                                              .verticalSpacing,
                                                          settings
                                                              .horizontalSpacing)),
                                            )
                                                .animate(key: ValueKey(filter))
                                                .fadeIn(
                                                    begin: 0.3,
                                                    duration: const Duration(
                                                        milliseconds: 150))
                                                .scale(
                                                    duration: const Duration(
                                                        milliseconds: 150),
                                                    curve: Curves.easeInOutQuad,
                                                    begin: const Offset(
                                                        0.99, 0.99),
                                                    end: const Offset(1, 1)),
                                          ),
                                          if (showLetterList)
                                            const Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: LetterList())
                                        ],
                                      ),
                                    ),
                                    if (showSearch)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: searchController,
                                                autocorrect: false,
                                                decoration: InputDecoration(
                                                    label: Icon(
                                                  Icons.search,
                                                  color: colors.secondary,
                                                )),
                                                onChanged: cubit.setFilter,
                                              ),
                                            ),
                                            if (filter.isNotEmpty)
                                              IconButton(
                                                  onPressed: () {
                                                    cubit.setFilter('');
                                                    searchController.text = '';
                                                  },
                                                  icon: const Icon(Icons.clear))
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
