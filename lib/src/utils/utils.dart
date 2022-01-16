import 'package:game_board/game_board.dart';

extension BoardExtension<T> on BoardCell<T> {
  bool sameRow(BoardCell<T> cell) => rowIndex == cell.rowIndex;

  bool sameColumn(BoardCell<T> cell) => columnIndex == cell.columnIndex;

  bool sameCell(BoardCell<T> cell) => sameRow(cell) && sameColumn(cell);

  bool sameValue(BoardCell<T> cell) => cell.data == data;

  bool areNeighbors(BoardCell<T> cell) {
    if (sameCell(cell)) return false;
    final _hasHorizontalNeighbors = isLeftNeighbor(cell) || isRightNeighbor(cell);
    final _hasVerticalNeighbors = isTopNeighbor(cell) || isBottomNeighbor(cell);
    return _hasHorizontalNeighbors || _hasVerticalNeighbors;
  }

  bool isLeftNeighbor(BoardCell<T> cell) {
    if (columnIndex == 0) return false;
    if (sameCell(cell)) return false;
    return cell.columnIndex == columnIndex + 1 && sameRow(cell);
  }

  bool isRightNeighbor(BoardCell<T> cell) {
    if (sameCell(cell)) return false;
    return cell.columnIndex == columnIndex - 1 && sameRow(cell);
  }

  bool isTopNeighbor(BoardCell<T> cell) {
    if (sameCell(cell)) return false;
    if (rowIndex == 0) return false;
    return cell.rowIndex == rowIndex - 1 && sameColumn(cell);
  }

  bool isBottomNeighbor(BoardCell<T> cell) {
    if (sameCell(cell)) return false;
    return cell.rowIndex == rowIndex + 1 && sameColumn(cell);
  }
}
