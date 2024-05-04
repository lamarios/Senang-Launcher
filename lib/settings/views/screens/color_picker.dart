import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
    return Column(
      children: [
        ColorPicker(
          colorPickerWidth: 200,
          pickerColor: pickedColor,
          onColorChanged: (value) => setState(() {
            pickedColor = value;
          }),
          enableAlpha: false,
          paletteType: PaletteType.hueWheel,
        ),
        TextButton(
            onPressed: () => widget.onChanged(pickedColor),
            child: const Text('Apply'))
      ],
    );
  }
}
