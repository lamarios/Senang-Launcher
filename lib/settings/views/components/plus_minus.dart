import 'package:flutter/material.dart';

class PlusMinus extends StatelessWidget {
  final double value;
  final double? min;
  final double? max;
  final double step;
  final Function(double newValue) onChanged;

  const PlusMinus(
      {super.key,
      required this.value,
      this.min,
      this.max,
      this.step = 1,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              final newValue = value - step;
              if (newValue >= (min ?? -double.maxFinite)) {
                onChanged(newValue);
              }
            },
            icon: const Icon(Icons.remove)),
        Text(value.toStringAsFixed(2)),
        IconButton(
            onPressed: () {
              final newValue = value + step;
              if (newValue <= (max ?? double.maxFinite)) {
                onChanged(newValue);
              }
            },
            icon: const Icon(Icons.add)),
      ],
    );
  }
}
