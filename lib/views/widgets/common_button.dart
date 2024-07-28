import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;
  final bool isLoading;

  const CommonButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.verticalPadding = 15.0,
      this.horizontalPadding = 100.0,
      this.fontSize = 16.0,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: theme.primaryColor, // Use theme primary color
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              )
            : Text(
                text,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: theme.backgroundColor,
                  fontSize: fontSize,
                ),
              ),
      ),
    );
  }
}
