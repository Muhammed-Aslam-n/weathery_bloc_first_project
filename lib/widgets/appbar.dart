import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? bgColor;
  final Color? textColor;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.actions,
      this.leading,
      this.bgColor,
      this.textColor})
      : super(key: key);

  @override
  Widget get child => AppBar(
        title: Text(
          title ?? '',
          style: TextStyle(
            color: textColor ?? Colors.redAccent,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: leading,
        actions: actions,
        backgroundColor: bgColor ?? const Color(0xFFf8f8f8),
      );

  @override
  Size get preferredSize => const Size(80, 80);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
