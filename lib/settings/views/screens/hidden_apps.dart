import 'package:auto_route/annotations.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class HiddenAppScreen extends StatelessWidget {
  const HiddenAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text(locals.hiddenApps),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocProvider(
          create: (context) => AppListCubit(
              const AppListState(), context.read<SettingsCubit>(),
              withIcons: true, getHidden: true)
            ..getApps(withLoading: true),
          child: BlocBuilder<AppListCubit, AppListState>(
            builder: (context, state) {
              final cubit = context.read<AppListCubit>();
              return state.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: state.apps.length,
                      itemBuilder: (context, index) {
                        final app = state.apps[index];
                        return CheckboxListTile(
                            key: ValueKey(app.app?.appName),
                            title: Row(
                              children: [
                                if (app.app! is ApplicationWithIcon) ...[
                                  Image.memory(
                                      (app.app! as ApplicationWithIcon).icon,
                                      width: 20,
                                      height: 20,
                                      gaplessPlayback: true),
                                  const Gap(10)
                                ],
                                Expanded(child: Text(app.app!.appName)),
                              ],
                            ),
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
