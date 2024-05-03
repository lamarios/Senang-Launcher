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
    }
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
