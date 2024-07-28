import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isHomeScreen;
  final double fontSize;

  const CommonAppBar(
      {Key? key,
      required this.title,
      this.actions,
      this.isHomeScreen = false,
      this.fontSize = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color appBarColor = theme.scaffoldBackgroundColor;
    Color titleColor = theme.primaryColor;

    if (isHomeScreen) {
      titleColor = theme.scaffoldBackgroundColor;
      appBarColor = theme.primaryColor;
    }

    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.displayLarge
            ?.copyWith(color: titleColor, fontSize: fontSize),
      ),
      backgroundColor: appBarColor,
      elevation: 0,
      actions: actions,
      iconTheme: IconThemeData(color: theme.primaryColor),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
