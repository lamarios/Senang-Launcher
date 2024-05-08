import 'package:flutter/material.dart';

enum ListStyle {
  wrap(Icons.wrap_text, TextAlign.center),
  left(Icons.format_align_left, TextAlign.left),
  center(Icons.format_align_center, TextAlign.center),
  right(Icons.format_align_right, TextAlign.right);

  final IconData icon;
  final TextAlign textAlign;

  const ListStyle(this.icon, this.textAlign);

  Widget wrapApps(BuildContext context, List<Widget> children,
      double verticalSpacing, double horizontalSpacing) {
    return switch (this) {
      wrap => Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runSpacing: verticalSpacing,
          spacing: horizontalSpacing,
          children: children),
      left => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing / 2,
                        vertical: verticalSpacing / 2),
                    child: e,
                  ))
              .toList(),
        ),
      right => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: children
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing / 2,
                        vertical: verticalSpacing / 2),
                    child: e,
                  ))
              .toList(),
        ),
      center => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing / 2,
                        vertical: verticalSpacing / 2),
                    child: e,
                  ))
              .toList(),
        ),
    };
  }
}
