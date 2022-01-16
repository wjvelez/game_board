import 'package:flutter/material.dart';
import 'package:game_board/game_board.dart';

class Board<T> extends StatelessWidget {
  const Board({
    Key? key,
    required this.cellHeight,
    required this.cellBuilder,
    required this.onCellTap,
    required this.controller,
    this.cellDecorator,
  }) : super(key: key);

  final double cellHeight;

  final CellBuilder<T> cellBuilder;
  final void Function(BoardCell<T> cell) onCellTap;
  final BoardController<T> controller;
  final CellDecorator<T>? cellDecorator;

  @override
  Widget build(BuildContext context) {
    final rows = controller.rows;
    final columns = controller.columns;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < rows; i++)
              SizedBox(
                height: cellHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var j = 0; j < columns; j++)
                      InkWell(
                        onTap: () => onCellTap(
                          controller.getBoardCell(i, j),
                        ),
                        child: Container(
                          width: cellHeight,
                          height: cellHeight,
                          decoration: cellDecorator != null
                              ? cellDecorator!(
                                  controller.getBoardCell(i, j),
                                )
                              : BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                          child: Center(
                            child: cellBuilder(
                              controller.getBoardCell(i, j),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
