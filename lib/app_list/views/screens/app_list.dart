import 'package:access_wallpaper/access_wallpaper.dart';
import 'package:auto_route/annotations.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/app_list/views/components/app.dart';
import 'package:senang_launcher/app_list/views/components/letter_list.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:senang_launcher/settings/views/screens/settings.dart';

@RoutePage()
class AppListScreen extends StatelessWidget {
  const AppListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settings) {
            final loading =
                context.select((AppListCubit value) => value.state.loading);

            final cubit = context.read<AppListCubit>();
            return Stack(
              children: [
                if (settings.showWallPaper)
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
                if (settings.showWallPaper)
                  Positioned.fill(
                      child: Container(
                    color: colors.background.withOpacity(settings.wallPaperDim),
                  )),
                loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 58),
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
                                    if (settings.showLetterList &&
                                        (!settings.letterListOnRight ||
                                            settings.showInvisibleLetterList))
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: LetterList(
                                            rightMode: false,
                                            invisible: settings
                                                    .letterListOnRight &&
                                                settings
                                                    .showInvisibleLetterList,
                                          )),
                                    const Expanded(
                                      child: SingleChildScrollView(
                                          child: _AppList()),
                                    ),
                                    if (settings.showLetterList &&
                                        (settings.letterListOnRight ||
                                            settings.showInvisibleLetterList))
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: LetterList(
                                            rightMode: true,
                                            invisible: !settings
                                                    .letterListOnRight &&
                                                settings
                                                    .showInvisibleLetterList,
                                          ))
                                  ],
                                ),
                              ),
                              if (settings.showSearch)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: cubit.searchController,
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                              label: Icon(
                                            Icons.search,
                                            color: colors.secondary,
                                          )),
                                          onChanged: cubit.setFilter,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AppList extends StatelessWidget {
  const _AppList();

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settings) {
        final apps = context.select((AppListCubit value) =>
            value.state.apps.where((element) => !element.hidden));
        final filter =
            context.select((AppListCubit value) => value.state.filter);
        final isLetterFilter =
            context.select((AppListCubit value) => value.state.isLetterFilter);

        final cubit = context.read<AppListCubit>();

        return isLetterFilter && filter == settingLetterPlaceHolder
            ? Text(
                locals.releaseToOpenSettings,
                style: textTheme.displayMedium?.copyWith(color: colors.primary),
                textAlign: TextAlign.center,
              )
            : settings.listStyle.wrapApps(context,
                children: apps
                    .where((element) {
                      if (isLetterFilter) {
                        return element.app!.appName
                            .toLowerCase()
                            .startsWith(filter);
                      } else {
                        return element.app!.appName
                            .toLowerCase()
                            .contains(filter);
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
                          cubit.searchController.text = '';
                        },
                        child: App(key: ValueKey(e.app!.packageName), app: e)))
                    .toList(),
                verticalSpacing: settings.verticalSpacing,
                horizontalSpacing: settings.horizontalSpacing);
      },
    );
  }
}
