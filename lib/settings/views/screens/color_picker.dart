import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ColorPickerSheet extends StatefulWidget {
  final Color color;
  final Function(Color value) onChanged;

  const ColorPickerSheet(
      {super.key, required this.color, required this.onChanged});

  @override
  State<ColorPickerSheet> createState() => _ColorPickerSheetState();
}

class _ColorPickerSheetState extends State<ColorPickerSheet> {
  late Color pickedColor = widget.color;

  @override
  Widget build(BuildContext context) {
    final locals = AppLocalizations.of(context)!;

    return Column(
      children: [
        ColorPicker(
          color: pickedColor,
          pickersEnabled: const {
            ColorPickerType.primary: true,
            ColorPickerType.accent: true,
            ColorPickerType.wheel: true,
          },
          onColorChanged: (value) => setState(() {
            pickedColor = value;
          }),
        ),
        TextButton(
            onPressed: () => widget.onChanged(pickedColor),
            child: Text(locals.apply))
      ],
    );
  }
}
