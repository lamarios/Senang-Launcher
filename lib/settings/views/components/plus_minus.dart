import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlusMinus extends StatefulWidget {
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
  State<PlusMinus> createState() => _PlusMinusState();
}

class _PlusMinusState extends State<PlusMinus> {
  bool isPressing = false;

  void decrease() {
    final newValue = widget.value - widget.step;
    if (newValue >= (widget.min ?? -double.maxFinite)) {
      widget.onChanged(newValue);
    }
  }

  void increase() {
    final newValue = widget.value + widget.step;
    if (newValue <= (widget.max ?? double.maxFinite)) {
      widget.onChanged(newValue);
    }
  }

  Future<void> keepOn(Function func) async {
    isPressing = true;
    do {
      func();
      await Future.delayed(const Duration(milliseconds: 100));
    } while (isPressing);
  }

  stop() {
    setState(() {
      isPressing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onLongPressStart: (details) => keepOn(decrease),
          onLongPressEnd: (details) => stop(),
          child: IconButton(
            onPressed: decrease,
            icon: const Icon(Icons.remove),
          ),
        ),
        Text(widget.value.toStringAsFixed(2)),
        GestureDetector(
            onLongPressStart: (details) => keepOn(increase),
            onLongPressEnd: (details) => stop(),
            child:
                IconButton(onPressed: increase, icon: const Icon(Icons.add))),
      ],
    );
  }
}
