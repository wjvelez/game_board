import 'package:flutter/material.dart';
import 'package:game_board/game_board.dart';

class BoardController<T> extends ChangeNotifier {
  BoardController({
    required this.totalRows,
    required this.totalColumns,
  }) {
    initializeCells();
  }

  late int totalRows;
  late int totalColumns;

  int get totalCells => totalRows * totalColumns;

  int boardIndex(BoardCell<T> cell) => (cell.rowIndex * totalRows) + cell.columnIndex;

  int get rows => totalRows;
  int get columns => totalColumns;

  final _board = <BoardCell<T>>[];
  List<BoardCell<T>> get board => _board;

  BoardCell<T> getBoardCell(int row, int column) {
    return board.firstWhere(
      (e) => e.sameCell(
        BoardCell<T>(
          columnIndex: column,
          rowIndex: row,
        ),
      ),
    );
  }

  void initializeCells() {
    for (var i = 0; i < totalRows; i++) {
      for (var j = 0; j < totalColumns; j++) {
        final _cell = BoardCell<T>(
          rowIndex: i,
          columnIndex: j,
        );
        board.add(_cell);
      }
    }
  }

  void selectedCell(int row, int column) {
    final _cell = getBoardCell(row, column);
    final _index = _board.indexWhere((e) => e.sameCell(_cell));
    if (_index != -1) {
      _board[_index] = _cell.select(
        !_cell.isSelected,
      );
    }
  }

  int cellValue(BoardCell<int> cell) => totalCells * cell.rowIndex + cell.columnIndex;

  void updateCell(int row, int column, BoardCell<T> cell) {
    final _oldCell = getBoardCell(row, column);
    if (cell.sameCell(_oldCell)) {
      final _index = _board.indexWhere((e) => e.sameCell(_oldCell));
      if (_index != -1) {
        _board[_index] = cell;
        notifyListeners();
      }
    }
  }

  void fromValues(List<T> values) {
    assert(values.length == board.length);
    board.clear();

    var rowIndex = 0;
    for (var i = 0; i < values.length; i++) {
      final colIndex = i % totalColumns;

      if (colIndex == 0 && i != 0) {
        rowIndex++;
      }
      board.add(
        BoardCell(
          columnIndex: colIndex,
          rowIndex: rowIndex,
          data: values[i],
        ),
      );
    }
  }

  void loadCells(List<BoardCell<T>> boardCells) {
    assert(boardCells.length < board.length);

    for (var i = 0; i < boardCells.length; i++) {
      final _cell = boardCells[i];
      final _index = board.indexWhere((e) => e.sameCell(_cell));
      if (_index != -1) {
        board[_index] = _cell;
      }
    }
    notifyListeners();
  }

  List<BoardCell<T>> cellsInRow(int row) => board
      .where(
        (e) => e.rowIndex == row,
      )
      .toList();

  List<BoardCell<T>> cellsInColumn(int column) => board
      .where(
        (e) => e.columnIndex == column,
      )
      .toList();

  bool areNeighbors(
    BoardCell<T> cell1,
    BoardCell<T> cell2,
  ) {
    if (cell1.sameCell(cell2)) return false;
    final _horizontalNeighbors = areHorizontalNeighbors(cell1, cell2);
    final _verticalNeighbors = areVerticalNeighbors(cell1, cell2);
    return _horizontalNeighbors || _verticalNeighbors;
  }

  bool areHorizontalNeighbors(
    BoardCell<T> cell1,
    BoardCell<T> cell2,
  ) {
    if (cell1.sameCell(cell2)) return false;
    final _delta = (cell1.columnIndex - cell2.columnIndex).abs();
    return _delta == 1;
  }

  bool areVerticalNeighbors(
    BoardCell<T> cell1,
    BoardCell<T> cell2,
  ) {
    if (cell1.sameCell(cell2)) return false;
    final _delta = (cell1.rowIndex - cell2.rowIndex).abs();
    return _delta == 1;
  }

  List<BoardCell<T>> getHorizontalNeighbors(BoardCell<T> cell) {
    final setNeighbors = board
        .where(
          (e) => e.isLeftNeighbor(cell) || e.isRightNeighbor(cell),
        )
        .toSet();
    return setNeighbors.toList();
  }
}
