import 'package:flutter/material.dart';
import 'package:lib_msaadev/lib_msaadev.dart';

class SelectButton extends StatelessWidget {
  final bool isEnabled;
  final String label;
  final Function()? tap;
  final Color? enabledColor, disabledColor;
  final double? width, height;
  const SelectButton(
      {Key? key,
      this.isEnabled = false,
      required this.label,
      this.tap,
      this.width,
      this.height,
      this.enabledColor = Colors.green,
      this.disabledColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 500.millisecondsDuration,
      padding: [20, 5].paddingSymmetric,
      margin: 5.paddingAll,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: 5.customRadius,
          color: isEnabled ? enabledColor : disabledColor),
      child: Text(
        label,
        style: context.textTheme.headline6?.copyWith(color: Colors.white),
      ),
    ).onTap(tap);
  }
}