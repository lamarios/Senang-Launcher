import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_launcher/app_list/state/app_list.dart';
import 'package:simple_launcher/settings/state/settings.dart';

@RoutePage()
class HiddenAppScreen extends StatelessWidget {
  const HiddenAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hidden apps'),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocProvider(
          create: (context) =>
              AppListCubit(const AppListState(), context.read<SettingsCubit>())
                ..getApps(),
          child: BlocBuilder<AppListCubit, AppListState>(
            builder: (context, state) {
              final cubit = context.read<AppListCubit>();
              return ListView.builder(
                itemCount: state.apps.length,
                itemBuilder: (context, index) {
                  final app = state.apps[index];
                  return CheckboxListTile(
                      title: Text(app.app!.appName),
                      value: app.hidden,
                      onChanged: (value) => cubit.hideApp(app, value));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
