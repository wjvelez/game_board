import 'package:flutter/material.dart';

class DemoButton extends StatelessWidget {
  const DemoButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.textStyle,
    this.size,
  });

  final String label;
  final TextStyle? textStyle;
  final VoidCallback onTap;
  final Color? color;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      child: Text(
        label,
      ),
    );
  }
}
