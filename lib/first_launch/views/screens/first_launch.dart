import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
import 'package:open_settings/open_settings.dart';
import 'package:senang_launcher/app_list/state/app_list.dart';
import 'package:senang_launcher/router.dart';
import 'package:senang_launcher/settings/state/settings.dart';
import 'package:senang_launcher/utils/utils.dart';

@RoutePage()
class FirstLaunchScreen extends StatefulWidget {
  const FirstLaunchScreen({super.key});

  @override
  State<FirstLaunchScreen> createState() => _FirstLaunchScreenState();
}

class _FirstLaunchScreenState extends State<FirstLaunchScreen> {
  int step = 0;
  late final pageController = PageController(initialPage: step);

  nextStep() {
    if (step == 2) {
      context
          .read<SettingsCubit>()
          .updateSetting(firstLaunchSettingName, false.toString());
      AutoRouter.of(context).replaceAll([const AppListRoute()]);
    } else {
      setState(() {
        step++;
        pageController.animateToPage(step,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutQuad);
      });
    }
  }

  previousStep() {
    setState(() {
      step = max(0, step - 1);
      pageController.animateToPage(step,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutQuad);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                children: const [FirstScreen(), SecondScreen(), ThirdScreen()],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (step > 0)
                  TextButton(
                      onPressed: previousStep, child: Text(locals.previous)),
                TextButton(
                    onPressed: nextStep,
                    child: Text(step == 2
                        ? locals.startUsingSenangLauncher
                        : locals.next))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                locals.introText1,
                style: textTheme.headlineMedium,
              ),
            ),
            const Gap(20),
            Text(
              locals.introText2,
              textAlign: TextAlign.center,
            ),
            const Gap(50),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 0,
              spacing: 10,
              children: locals.introExplanation1.split(' ').map((e) {
                var style = textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                );

                if (e == locals.introMoreWord) {
                  style = style?.copyWith(
                      height: 1,
                      fontSize: 50,
                      color: tintColor(colors.primary, brightness, 1));
                }
                if (e == locals.introAppWord) {
                  style = style?.copyWith(
                      height: 1,
                      fontSize: 30,
                      color: tintColor(colors.primary, brightness, 0.5));
                }
                if (e == locals.introBiggerWord) {
                  style = style?.copyWith(
                      height: 1,
                      fontSize: 40,
                      color: tintColor(colors.primary, brightness, 0.75));
                }

                return Text(
                  e,
                  textAlign: TextAlign.center,
                  style: style,
                );
              }).toList(),
            ),
            const Gap(50),
            Text(
              locals.introExplanation1SubText,
              textAlign: TextAlign.center,
            )
          ]),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                './lib/assets/app-list.gif',
                width: 200,
              )),
          const Gap(50),
          Text(locals.introExplanation2),
        ],
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  accessNotifications(BuildContext context) async {
    final bool allowed =
        await NotificationListenerService.isPermissionGranted();

    if (!allowed) {
      final bool status = await NotificationListenerService.requestPermission();

      if (!status) {
        return;
      }
    }

    if (context.mounted) {
      // at this point we should have access
      await context
          .read<SettingsCubit>()
          .updateSetting(colorOnNotificationSettingName, true.toString());

      if (context.mounted) {
        context.read<AppListCubit>().setUpNotificationListener();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locals.coupleLastThings,
            style: textTheme.titleLarge,
          ),
          const Gap(50),
          Text(locals.allowAccessToNotificationsExplanation),
          const Gap(10),
          FilledButton.tonal(
              onPressed: () => accessNotifications(context),
              child: Text(locals.allowAccessToNotifications)),
          const Gap(50),
          Text(locals.introSetAsDefaultLauncherExplanation),
          const Gap(10),
          Text(
            locals.setAsDefaultLauncherExplanation,
            style: textTheme.labelSmall,
          ),
          const Gap(10),
          FilledButton.tonal(
              onPressed: () {
                OpenSettings.openManageDefaultAppsSetting();
              },
              child: Text(locals.setAsDefaultLauncher))
        ],
      ),
    );
  }
}
