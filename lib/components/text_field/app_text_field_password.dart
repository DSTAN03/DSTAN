import 'package:flutter/material.dart';

class AppTextFieldPassword extends StatefulWidget {
  AppTextFieldPassword({
    super.key,
    this.controller,
    this.onChanged,
    Color? bgColor,
    this.hintText,
    this.hintColor = Colors.grey,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    this.textInputAction, required IconData prefixIcon,
  })  : bgColor = bgColor ?? Colors.grey.withOpacity(0.36),
        borderRadius = borderRadius ?? BorderRadius.circular(8.6),
        padding = padding ??
            const EdgeInsets.symmetric(vertical: 2.8)
                .copyWith(left: 16.0, right: 2.0);

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Color bgColor;
  final String? hintText;
  final Color hintColor;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final TextInputAction? textInputAction;

  @override
  State<AppTextFieldPassword> createState() => _AppTextFieldPasswordState();
}

class _AppTextFieldPasswordState extends State<AppTextFieldPassword> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
          color: widget.bgColor, borderRadius: widget.borderRadius),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: !showPassword,
        textAlignVertical: const TextAlignVertical(y: 0.0),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle:
              TextStyle(color: widget.hintColor, fontWeight: FontWeight.w500),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => showPassword = !showPassword),
            child: Icon(
              Icons.remove_red_eye,
              color:
                  showPassword ? Colors.brown.withOpacity(0.8) : Colors.green,
            ),
          ),
        ),
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
