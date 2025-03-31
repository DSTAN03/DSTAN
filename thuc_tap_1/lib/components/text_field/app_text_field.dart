import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    Color? bgColor,
    this.hintText,
    this.hintColor = Colors.grey,
    BorderRadiusGeometry? borderRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.8),
    this.textInputAction, required IconData prefixIcon,
  })  : bgColor = bgColor ?? Colors.grey.withOpacity(0.36),
        borderRadius = borderRadius ?? BorderRadius.circular(8.6);

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Color bgColor;
  final String? hintText;
  final Color hintColor;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor, fontWeight: FontWeight.w500),
        ),
        textInputAction: textInputAction,
      ),
    );
  }
}
