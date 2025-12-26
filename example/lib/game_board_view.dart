import 'package:example/buttons_row.dart';
import 'package:example/demo_cell.dart';

import 'package:example/game_board_view_provider.dart';
import 'package:example/models/demo_board_type.dart';
import 'package:flutter/material.dart';
import 'package:game_board/game_board.dart';
import 'package:provider/provider.dart';

final alphabets = List<int>.generate(26, (int index) => index + 65);

class GameBoardView extends StatelessWidget {
  const GameBoardView._();
  static Widget init() {
    return ChangeNotifierProvider<GameBoardViewProvider>(
      create: (_) => GameBoardViewProvider(),
      child: const GameBoardView._(),
    );
  }

  String columnLabels(int columnIndex) {
    final index = alphabets[columnIndex];
    return String.fromCharCode(index);
  }

  int sumRow(BuildContext context, int rowIndex) {
    final prov = context.read<GameBoardViewProvider>();
    final rows = prov.boardController.cellsInRow(rowIndex);
    final total = rows.map((e) => e.data ?? 0).reduce((a, b) => a + b);
    return total;
  }

  int sumColumn(BuildContext context, int columnIndex) {
    final prov = context.read<GameBoardViewProvider>();
    final columns = prov.boardController.cellsInColumn(columnIndex);
    final total = columns.map((e) => e.data ?? 0).reduce((a, b) => a + b);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyHeight = size.height - kToolbarHeight;
    final provider = Provider.of<GameBoardViewProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Board demo'),
        backgroundColor: Colors.deepPurple,
        titleTextStyle: Theme.of(context).primaryTextTheme.headlineSmall,
      ),
      backgroundColor: Colors.green[500]!,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.greenAccent,
                Colors.green[500]!,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Board size'),
                    ),
                    Expanded(
                      child: DropdownButton<DemoBoardType>(
                        value: provider.boardType,
                        onChanged: (e) => provider.updateBoardSize(e!),
                        underline: const SizedBox.shrink(),
                        items: DemoBoardType.values.map((e) {
                          final countCell = e.cellCount();
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              '$countCell x $countCell',
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GameBoard<int>(
                  controller: provider.boardController,
                  onCellTap: provider.selectCell,
                  cellBuilder: (boardCell) {
                    return DemoCell(
                      rowIndex: boardCell.rowIndex,
                      columnIndex: boardCell.columnIndex,
                    );
                  },
                  boardLabels: BoardLabels(
                    top: (i) => Center(
                      child: Text(columnLabels(i)),
                    ),
                    left: (i) => Center(
                      child: Text('${i + 1}'),
                    ),
                    right: (i) => Center(
                      child: FittedBox(
                        child: Text('${sumRow(context, i)}'),
                      ),
                    ),
                    bottom: (i) => Center(
                      child: FittedBox(
                        child: Text('${sumColumn(context, i)}'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: bodyHeight * .15,
                child: const ButtonsRow(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
