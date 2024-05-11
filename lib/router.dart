import 'package:auto_route/auto_route.dart';
import 'package:senang_launcher/app_list/views/screens/app_list.dart';
import 'package:senang_launcher/first_launch/views/screens/first_launch.dart';
import 'package:senang_launcher/settings/views/screens/hidden_apps.dart';

import 'settings/views/screens/stats.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  final bool firstLaunch;

  AppRouter({super.navigatorKey, required this.firstLaunch});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AppListRoute.page, initial: !firstLaunch),
        AutoRoute(page: HiddenAppRoute.page),
        AutoRoute(page: StatsRoute.page),
        AutoRoute(page: FirstLaunchRoute.page, initial: firstLaunch)
      ];
}
