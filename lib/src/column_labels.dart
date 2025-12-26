import 'package:flutter/material.dart';

const colorsLst = [
  Colors.amber,
  Colors.pink,
  Colors.grey,
  Colors.lime,
];

class ColumnLabels extends StatelessWidget {
  const ColumnLabels({
    super.key,
    required this.rows,
    required this.cellSize,
    required this.labelBuilder,
    required this.hasLeftLabels,
    required this.hasRighlabels,
  });

  final int rows;
  final double cellSize;

  final Widget Function(int) labelBuilder;
  final bool hasLeftLabels;
  final bool hasRighlabels;

  double boardPadding(BoxConstraints constraints) {
    final minWidth = constraints.minWidth;
    final boardWidth = (cellSize * rows) + (rows * 1) - 2;
    return minWidth - boardWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasLeftLabels)
            SizedBox(
              height: kToolbarHeight,
              width: boardPadding(constraints) / (hasRighlabels ? 2 : 1),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < rows; i++)
                  SizedBox(
                    width: cellSize,
                    height: kToolbarHeight,
                    child: labelBuilder(i),
                  ),
              ],
            ),
          ),
          if (hasRighlabels)
            SizedBox(
              height: kToolbarHeight,
              width: boardPadding(constraints) / (hasLeftLabels ? 2 : 1),
            ),
        ],
      );
    });
  }
}
