import 'package:auto_route/annotations.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_launcher/app_list/state/app_list.dart';
import 'package:simple_launcher/app_list/views/screens/app.dart';

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
            create: (context) => AppListCubit(const AppList())..getApps(),
            child: Builder(
              builder: (context) {
                final apps =
                    context.select((AppListCubit value) => value.state.apps);

                final filter =
                    context.select((AppListCubit value) => value.state.filter);
                final cubit = context.read<AppListCubit>();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              runSpacing: 0,
                              spacing: 15,
                              children: apps
                                  .where((element) => element.app!.appName
                                      .toLowerCase()
                                      .contains(filter.toLowerCase()))
                                  .map((e) => GestureDetector(
                                      onTap: () {
                                        if (!kDebugMode) {
                                          DeviceApps.openApp(
                                              e.app!.packageName);
                                        }
                                        cubit.increaseLaunches(e);
                                        cubit.setFilter('');
                                        searchController.text = '';
                                      },
                                      child: App(app: e)))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
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
                );
              },
            )),
      ),
    );
  }
}
