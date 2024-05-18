import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senang_launcher/settings/state/settings.dart';

class FontSettings extends StatefulWidget {
  const FontSettings({super.key});

  @override
  State<FontSettings> createState() => _FontSettingsState();
}

class _FontSettingsState extends State<FontSettings> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locals = AppLocalizations.of(context)!;

    final fonts = GoogleFonts.asMap();
    final names = fonts.keys
        .where(
          (element) =>
              element.toLowerCase().contains(controller.text.toLowerCase()),
        )
        .toList();

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settings) {
        final cubit = context.read<SettingsCubit>();
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(hintText: locals.search),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () => cubit.deleteSetting(fontSettingName),
                    child: Text(locals.useDefaultFont))
              ],
            ),
            SwitchListTile(
              value: settings.fontWeight == FontWeight.bold,
              title: Text(locals.bold),
              onChanged: (bool value) {
                cubit.updateSetting(boldFontSettingName, value.toString());
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    final font = names[index];
                    return InkWell(
                        onTap: () {
                          cubit.updateSetting(fontSettingName, font);
                        },
                        child: Text(font,
                            style: fonts[font]!().copyWith(
                                fontSize: 20,
                                fontWeight: settings.fontWeight,
                                color: settings.textFont == font
                                    ? colors.primary
                                    : null)));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
