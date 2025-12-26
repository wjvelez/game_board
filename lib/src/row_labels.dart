import 'package:flutter/material.dart';

class RowLabels extends StatelessWidget {
  const RowLabels({
    super.key,
    required this.cellSize,
    required this.columns,
    required this.labelBuilder,
  });

  final int columns;
  final double cellSize;

  final Widget Function(int) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < columns; i++)
            SizedBox(
              height: cellSize,
              child: labelBuilder(i),
            ),
        ],
      ),
    );
  }
}
