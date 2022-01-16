import 'package:flutter/material.dart';

class DemoButton extends StatelessWidget {
  const DemoButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.color,
    this.textStyle,
    this.size,
  }) : super(key: key);

  final String label;
  final TextStyle? textStyle;
  final VoidCallback onTap;
  final Color? color;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        label,
        style: textStyle ??
            Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).primaryIconTheme.color,
                ),
      ),
    );
  }
}
