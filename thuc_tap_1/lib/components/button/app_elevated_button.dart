import 'package:flutter/material.dart';
import '../app_box_shadow.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.onPressed,
    this.height = 54.0,
    this.icon,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 16.8,
    this.color = Colors.red,
    this.borderColor = Colors.red,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 30.0),
  });

  const AppElevatedButton.outline({
    super.key,
    this.onPressed,
    this.height = 54.0,
    this.icon,
    required this.text,
    this.textColor = Colors.red,
    this.fontSize = 16.8,
    this.color = Colors.white,
    this.borderColor = Colors.red,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 30.0),
  });

  const AppElevatedButton.small({
    super.key,
    this.onPressed,
    this.height = 36.0,
    this.icon,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.color = Colors.red,
    this.borderColor = Colors.red,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
  });

  const AppElevatedButton.smallOutline({
    super.key,
    this.onPressed,
    this.height = 36.0,
    this.icon,
    required this.text,
    this.textColor = Colors.red,
    this.fontSize = 16.0,
    this.color = Colors.white,
    this.borderColor = Colors.red,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
  });

  final Function()? onPressed;
  final double height;
  final Icon? icon;
  final String text;
  final Color textColor;
  final double fontSize;
  final Color color;
  final Color borderColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        height: height,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor, width: 1.2),
          borderRadius: borderRadius,
          boxShadow: AppBoxShadow.boxShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 4.0),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
