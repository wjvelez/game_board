import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_board/game_board.dart';

typedef CellBuilder<T> = Widget Function(BoardCell<T>);
typedef CellDecorator<T> = BoxDecoration Function(BoardCell<T>);

class GameBoard<T> extends StatefulWidget {
  const GameBoard({
    Key? key,
    required this.controller,
    required this.cellBuilder,
    required this.onCellTap,
    this.initialCells,
    this.cellDecorator,
    this.boardLabels,
  }) : super(key: key);

  final BoardController<T> controller;

  final CellBuilder<T> cellBuilder;
  final void Function(BoardCell<T> cell) onCellTap;
  final List<BoardCell<T>>? initialCells;
  final CellDecorator<T>? cellDecorator;
  final BoardLabels? boardLabels;

  @override
  _GameBoardState<T> createState() => _GameBoardState<T>();
}

class _GameBoardState<T> extends State<GameBoard<T>> {
  int selectedCell = -1;

  List<int> selectedCells = [];

  @override
  void initState() {
    super.initState();
    buildBoard();
  }

  buildBoard() {
    if (widget.initialCells != null) {
      widget.controller.loadCells(widget.initialCells!);
    }
  }

  var horizontalBorderSize = kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    final hasTopLabels = widget.boardLabels?.top != null;
    final hasLeftLabels = widget.boardLabels?.left != null;
    final hasRightLabels = widget.boardLabels?.right != null;
    final hasBottomLabels = widget.boardLabels?.bottom != null;

    if (hasLeftLabels && hasRightLabels) {
      horizontalBorderSize = kToolbarHeight / 2;
    } else if (!hasLeftLabels && !hasRightLabels) {
      horizontalBorderSize = 0;
    } else {
      horizontalBorderSize = 0;
    }

    return BoardControllerInheritedWidget<T>(
      controller: widget.controller,
      child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final rows = widget.controller.rows;
                final columns = widget.controller.rows;
                final minSize = min(constraints.minWidth, constraints.minHeight);
                final cellWidth = ((minSize - horizontalBorderSize) / rows) - 2;

                return Center(
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
                          hasRightabels: hasRightLabels,
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
                                width: kTextTabBarHeight / (hasRightLabels ? 2 : 1),
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
                                width: kTextTabBarHeight / (hasLeftLabels ? 2 : 1),
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
                          hasRightabels: hasRightLabels,
                        ),
                    ],
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
    Key? key,
    required Widget child,
    required this.controller,
  }) : super(
          key: key,
          child: child,
        );

  final BoardController<T> controller;

  static BoardControllerInheritedWidget? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
