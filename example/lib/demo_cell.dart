import 'package:example/game_board_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:game_board/game_board.dart';
import 'package:provider/provider.dart';

class DemoCell extends StatelessWidget {
  const DemoCell({
    Key? key,
    // required this.boardCell,
    required this.rowIndex,
    required this.columnIndex,
  }) : super(key: key);

  // final BoardCell boardCell;
  final int rowIndex;
  final int columnIndex;

  @override
  Widget build(BuildContext context) {
    // final totalCells = context.read<TakuzuProvider>().totalCells;
    final _cell = BoardCell<int>(columnIndex: columnIndex, rowIndex: rowIndex);
    final _selected = context.select<GameBoardViewProvider, bool>((prov) => prov.selectedCell.sameCell(_cell));
    final _initialCells = context.read<GameBoardViewProvider>().boardController.board;
    final _index = _initialCells.indexWhere((e) => e.sameCell(_cell));
    BoardCell<int>? _initialCell;
    if (_index != -1) {
      _initialCell = _initialCells[_index];
    }
    final _filledCells = context.read<GameBoardViewProvider>().filledCells;
    final _cellIndex = _filledCells.indexWhere((e) => e.sameCell(_cell));
    BoardCell<int>? _filledCell;
    if (_cellIndex != -1) {
      _filledCell = _filledCells[_cellIndex];
    }
    var _cellValue = '';
    if (_initialCell != null) {
      _cellValue = '${_initialCell.data ?? ''}';
    } else {
      _cellValue = '${_filledCell?.data ?? ''}';
    }
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: _selected
          ? BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
            )
          : null,
      child: Center(
        child: Text(
          _cellValue,
          // '${totalCells * rowIndex + columnIndex}',
        ),
      ),
    );
  }
}
