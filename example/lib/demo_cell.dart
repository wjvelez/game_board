import 'package:example/game_board_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:game_board/game_board.dart';
import 'package:provider/provider.dart';

class DemoCell extends StatelessWidget {
  const DemoCell({
    super.key,
    // required this.boardCell,
    required this.rowIndex,
    required this.columnIndex,
  });

  // final BoardCell boardCell;
  final int rowIndex;
  final int columnIndex;

  @override
  Widget build(BuildContext context) {
    final board = context.read<GameBoardViewProvider>().boardController;
    final cell = board.getBoardCell(rowIndex, columnIndex);

    final selected = context.select<GameBoardViewProvider, bool>((prov) => prov.selectedCell.sameCell(cell));

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: selected
          ? BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
            )
          : null,
      child: cell.data == null
          ? const SizedBox.shrink()
          : Center(
              child: Text('${cell.data ?? ''}'),
            ),
    );
  }
}
