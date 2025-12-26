// ignore_for_file: non_constant_identifier_names

import 'package:flutter_test/flutter_test.dart';

import 'package:game_board/game_board.dart';

void main() {
  group('BoardCell methods', () {
    final cell_i1j0 = BoardCell(rowIndex: 1, columnIndex: 0, data: 0);
    final cell_i1j1 = BoardCell(rowIndex: 1, columnIndex: 1, data: 1);
    final cell_i1j2 = BoardCell(rowIndex: 1, columnIndex: 2, data: 1);

    final cell_i2j0 = BoardCell(rowIndex: 2, columnIndex: 0, data: 0);
    final cell_i2j1 = BoardCell(rowIndex: 2, columnIndex: 1, data: 1);
    final cell_i2j2 = BoardCell(rowIndex: 2, columnIndex: 2, data: 1);

    test('isLeftNeighbor', () {
      expect(cell_i1j0.isLeftNeighbor(cell_i1j1), false);
      expect(cell_i1j1.isLeftNeighbor(cell_i1j0), false);
      expect(cell_i1j1.isLeftNeighbor(cell_i1j2), true);
      expect(cell_i1j0.isLeftNeighbor(cell_i2j0), false);
    });

    test('isRightNeighbor', () {
      expect(cell_i1j2.isRightNeighbor(cell_i1j1), true);
      expect(cell_i1j1.isRightNeighbor(cell_i1j0), true);
      expect(cell_i1j0.isRightNeighbor(cell_i1j1), false);
      expect(cell_i1j0.isRightNeighbor(cell_i2j0), false);
    });

    test('isTopNeighbor', () {
      expect(cell_i2j2.isTopNeighbor(cell_i1j2), true);
      expect(cell_i2j1.isTopNeighbor(cell_i1j1), true);
      expect(cell_i2j2.isTopNeighbor(cell_i2j1), false);
      expect(cell_i1j2.isTopNeighbor(cell_i2j2), false);
    });

    test('isBottomNeighbor', () {
      expect(cell_i1j0.isBottomNeighbor(cell_i2j0), true);
      expect(cell_i1j1.isBottomNeighbor(cell_i2j1), true);
      expect(cell_i1j1.isBottomNeighbor(cell_i1j2), false);
      expect(cell_i2j0.isBottomNeighbor(cell_i1j0), false);
    });
  });
}
