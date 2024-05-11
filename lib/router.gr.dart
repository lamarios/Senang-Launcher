// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AppListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppListScreen(),
      );
    },
    FirstLaunchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FirstLaunchScreen(),
      );
    },
    HiddenAppRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HiddenAppScreen(),
      );
    },
    StatsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StatsScreen(),
      );
    },
  };
}

/// generated route for
/// [AppListScreen]
class AppListRoute extends PageRouteInfo<void> {
  const AppListRoute({List<PageRouteInfo>? children})
      : super(
          AppListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FirstLaunchScreen]
class FirstLaunchRoute extends PageRouteInfo<void> {
  const FirstLaunchRoute({List<PageRouteInfo>? children})
      : super(
          FirstLaunchRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirstLaunchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HiddenAppScreen]
class HiddenAppRoute extends PageRouteInfo<void> {
  const HiddenAppRoute({List<PageRouteInfo>? children})
      : super(
          HiddenAppRoute.name,
          initialChildren: children,
        );

  static const String name = 'HiddenAppRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StatsScreen]
class StatsRoute extends PageRouteInfo<void> {
  const StatsRoute({List<PageRouteInfo>? children})
      : super(
          StatsRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
