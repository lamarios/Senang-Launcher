import 'package:auto_route/auto_route.dart';
import 'package:simple_launcher/app_list/views/screens/app_list.dart';
import 'package:simple_launcher/settings/views/screens/hidden_apps.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AppListRoute.page, initial: true),
        AutoRoute(page: HiddenAppRoute.page)
      ];
}
