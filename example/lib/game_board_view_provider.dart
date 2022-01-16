import 'dart:math';

import 'package:example/models/demo_board_type.dart';
import 'package:flutter/foundation.dart';

import 'package:game_board/game_board.dart';

class GameBoardViewProvider extends ChangeNotifier {
  GameBoardViewProvider() {
    boardType = DemoBoardType.four;
    totalCells = boardType.cellCount();
    buildBoard();
  }

  late BoardController<int> boardController;

  late DemoBoardType boardType;

  var _selectedCell = BoardCell<int>(
    // boardIndex: -1,
    columnIndex: -1,
    rowIndex: -1,
  );

  void buildBoard() {
    boardController = BoardController(
      totalRows: totalCells,
      totalColumns: totalCells,
    );

    updateBoardLoaded(true);
  }

  void updateBoardSize(DemoBoardType boardSize) {
    boardType = boardSize;
    totalCells = boardType.cellCount();
    buildBoard();
    notifyListeners();
  }

  int totalCells = 0;

  BoardCell<int> get selectedCell => _selectedCell;

  int cellValue(BoardCell<int> cell) => totalCells * cell.rowIndex + cell.columnIndex;

  void selectCell(BoardCell<int> cell) {
    print('cell tapped $cell');

    if (!_selectedCell.sameCell(cell)) {
      // _selectedCell = _selectedCell.select(false);
      _selectedCell = cell.select(true);
    }
    // final firstDialog = _selectedCell.belongFirstDiag();
    // final secondDialog = _selectedCell.belongSecondDiag(totalCells);

    notifyListeners();
  }

  // int get getInitialCells => pow(columns + ((boardType.index + 1) * 2), 2).toInt();

  bool _boardLoaded = false;
  bool get boardLoaded => _boardLoaded;
  void updateBoardLoaded(bool value) {
    _boardLoaded = value;
    notifyListeners();
  }

  final _filledCells = <BoardCell<int>>[];
  List<BoardCell<int>> get filledCells => _filledCells;

  void fillWithValue(int value) {
    for (var i = 0; i < boardController.board.length; i++) {
      final _cell = boardController.board[i];
      boardController.board[i] = _cell.copyWith(
        data: value,
      );
    }
    notifyListeners();
  }

  void fillRamdon() {
    for (var i = 0; i < boardController.board.length; i++) {
      final _value = Random().nextInt(boardController.totalCells);
      final _cell = boardController.board[i];
      boardController.board[i] = _cell.copyWith(
        data: _value,
      );
    }
    notifyListeners();
  }

  void addZero(int rowIndex, int columnIndex) {}

  void updateValue(int rowIndex, int columnIndex, int value) {
    final _cell = BoardCell<int>(
      columnIndex: columnIndex,
      rowIndex: rowIndex,
      data: value,
    );
    final _index = _filledCells.indexWhere(
      (e) => e.sameCell(_cell),
    );
    if (_index == -1) {
      _filledCells.add(_cell);
    } else {
      _filledCells[_index] = _cell;
    }
    notifyListeners();
  }
}

extension BoardTypeExtension on DemoBoardType {
  int cellCount() {
    switch (this) {
      case DemoBoardType.six:
        return 6;
      case DemoBoardType.eight:
        return 8;
      case DemoBoardType.ten:
        return 10;
      case DemoBoardType.twelve:
        return 12;
      case DemoBoardType.forthteen:
        return 14;
      default:
        return 4;
    }
  }
}
