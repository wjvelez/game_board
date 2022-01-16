import 'package:flutter/material.dart';

class ColumnLabels extends StatelessWidget {
  const ColumnLabels({
    Key? key,
    required this.rows,
    required this.cellSize,
    required this.labelBuilder,
    required this.hasLeftLabels,
    required this.hasRightabels,
  }) : super(key: key);

  final int rows;
  final double cellSize;

  final Widget Function(int) labelBuilder;
  final bool hasLeftLabels;
  final bool hasRightabels;

  double blankWidth() {
    if (hasLeftLabels && hasRightabels) {
      return kToolbarHeight / 2;
    } else {
      return kToolbarHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasLeftLabels)
          SizedBox(
            width: blankWidth(),
            height: kToolbarHeight,
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
        if (hasRightabels)
          SizedBox(
            width: blankWidth(),
            height: kToolbarHeight,
          ),
      ],
    );
  }
}
