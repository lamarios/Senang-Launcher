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
import 'package:senang_launcher/settings/views/screens/settings.dart';

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

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
            create: (context) => AppListCubit(
                const AppListState(), context.read<SettingsCubit>())
              ..getApps(),
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

                final isLetterFilter = context
                    .select((AppListCubit value) => value.state.isLetterFilter);

                final filter =
                    context.select((AppListCubit value) => value.state.filter);
                final cubit = context.read<AppListCubit>();
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
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      if (showWallpaper)
                        Positioned.fill(
                            child: Container(
                          color: colors.background.withOpacity(wallpaperDim),
                        )),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: GestureDetector(
                          onLongPress: () => SettingsSheet.showSettingsSheet(
                              context,
                              (context) => SettingsSheet(
                                    hideApp: cubit.hideApp,
                                  )).then((value) => cubit.getApps()),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            alignment: WrapAlignment.center,
                                            runSpacing:
                                                settings.verticalSpacing,
                                            spacing: settings.horizontalSpacing,
                                            children: apps
                                                .where((element) {
                                                  if (isLetterFilter) {
                                                    return element.app!.appName
                                                        .toLowerCase()
                                                        .startsWith(filter
                                                            .toLowerCase());
                                                  } else {
                                                    return element.app!.appName
                                                        .toLowerCase()
                                                        .contains(filter
                                                            .toLowerCase());
                                                  }
                                                })
                                                .map((e) => GestureDetector(
                                                    onLongPress: () =>
                                                        SettingsSheet
                                                            .showSettingsSheet(
                                                                context,
                                                                (context) =>
                                                                    SettingsSheet(
                                                                      hideApp: cubit
                                                                          .hideApp,
                                                                      app: e,
                                                                    )).then(
                                                            (value) => cubit
                                                                .getApps()),
                                                    onTap: () {
                                                      if (!kDebugMode) {
                                                        DeviceApps.openApp(
                                                            e.app!.packageName);
                                                      }
                                                      cubit.increaseLaunches(e);
                                                      cubit.setFilter('');
                                                      searchController.text =
                                                          '';
                                                    },
                                                    child: App(app: e)))
                                                .toList(),
                                          ),
                                        ),
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
                                              begin: const Offset(0.99, 0.99),
                                              end: const Offset(1, 1)),
                                    ),
                                    if (showLetterList)
                                      const Align(
                                          alignment: Alignment.center,
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
