import 'package:flutter/material.dart';

class RowLabels extends StatelessWidget {
  const RowLabels({
    Key? key,
    required this.cellSize,
    required this.columns,
    required this.labelBuilder,
    this.width,
  }) : super(key: key);

  final int columns;
  final double cellSize;
  final double? width;

  final Widget Function(int) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < columns; i++)
            SizedBox(
              width: width,
              height: cellSize,
              child: labelBuilder(i),
            ),
        ],
      ),
    );
  }
}
