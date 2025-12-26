import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_board/game_board.dart';

typedef CellBuilder<T> = Widget Function(BoardCell<T>);
typedef CellDecorator<T> = BoxDecoration Function(BoardCell<T>);

class GameBoard<T> extends StatefulWidget {
  const GameBoard({
    super.key,
    required this.controller,
    required this.cellBuilder,
    required this.onCellTap,
    this.initialCells,
    this.cellDecorator,
    this.boardLabels,
  });

  final BoardController<T> controller;

  final CellBuilder<T> cellBuilder;
  final void Function(BoardCell<T> cell) onCellTap;
  final List<BoardCell<T>>? initialCells;
  final CellDecorator<T>? cellDecorator;
  final BoardLabels? boardLabels;

  @override
  State<GameBoard<T>> createState() => _GameBoardState<T>();
}

class _GameBoardState<T> extends State<GameBoard<T>> {
  int selectedCell = -1;

  List<int> selectedCells = [];

  @override
  void initState() {
    super.initState();
    buildBoard();
  }

  void buildBoard() {
    hasTopLabels = widget.boardLabels?.top != null;
    hasLeftLabels = widget.boardLabels?.left != null;
    hasRightLabels = widget.boardLabels?.right != null;
    hasBottomLabels = widget.boardLabels?.bottom != null;
    if (widget.initialCells != null) {
      widget.controller.loadCells(widget.initialCells!);
    }
  }

  double getCellWidth(BoxConstraints constraints) {
    double labelsWidth;
    if (hasLeftLabels && hasRightLabels) {
      labelsWidth = maxLabelWidth * 2;
    } else if (!hasLeftLabels && !hasRightLabels) {
      labelsWidth = 0;
    } else {
      labelsWidth = maxLabelWidth;
    }
    final minConstrains = min(constraints.minWidth, constraints.minHeight);
    final minSize = minConstrains - (2 * boardPadding);
    final cellWidth = ((minSize - labelsWidth) / widget.controller.rows) - 2;

    return cellWidth;
  }

  late bool hasTopLabels;
  late bool hasLeftLabels;
  late bool hasRightLabels;
  late bool hasBottomLabels;

  final boardPadding = 12.0;
  final maxLabelWidth = 24.0;

  @override
  Widget build(BuildContext context) {
    final rows = widget.controller.rows;
    final columns = widget.controller.rows;

    return BoardControllerInheritedWidget<T>(
      controller: widget.controller,
      child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final cellWidth = getCellWidth(constraints);
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: boardPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (hasTopLabels)
                          ColumnLabels(
                            cellSize: cellWidth,
                            rows: rows,
                            labelBuilder: widget.boardLabels!.top!,
                            hasLeftLabels: hasLeftLabels,
                            hasRighlabels: hasRightLabels,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (hasLeftLabels)
                              Expanded(
                                child: RowLabels(
                                  cellSize: cellWidth,
                                  columns: columns,
                                  labelBuilder: widget.boardLabels!.left!,
                                ),
                              ),
                            Board(
                              cellHeight: cellWidth,
                              cellBuilder: widget.cellBuilder,
                              onCellTap: widget.onCellTap,
                              controller: widget.controller,
                              cellDecorator: widget.cellDecorator,
                            ),
                            if (hasRightLabels)
                              Expanded(
                                child: RowLabels(
                                  cellSize: cellWidth,
                                  columns: columns,
                                  labelBuilder: widget.boardLabels!.right!,
                                ),
                              ),
                          ],
                        ),
                        if (hasBottomLabels)
                          ColumnLabels(
                            cellSize: cellWidth,
                            rows: rows,
                            labelBuilder: widget.boardLabels!.bottom!,
                            hasLeftLabels: hasLeftLabels,
                            hasRighlabels: hasRightLabels,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

typedef LabelBuilder = Widget Function(int);

class BoardLabels {
  BoardLabels({
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  LabelBuilder? top;
  LabelBuilder? left;
  LabelBuilder? right;
  LabelBuilder? bottom;
}

class BoardControllerInheritedWidget<T> extends InheritedWidget {
  const BoardControllerInheritedWidget({
    super.key,
    required super.child,
    required this.controller,
  });

  final BoardController<T> controller;

  static BoardControllerInheritedWidget? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
