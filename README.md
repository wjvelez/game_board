Board with `n` rows and `m` columns.

## Features

- Display a game board with `n` rows and `m` columns.
- On cell tap callback.
- Use controller to manipulate the board content (Board Cells)



## Getting started

In the pubspec.yaml of your flutter project, add the following dependency:

```yaml
dependencies:
 game_board: <latest-version>
```

## Usage
Need to include the import the package to the dart file where it will be used, use the below command,
```dart
import 'package:game_board/game_board.dart';
```

### Initialize the controller:

```dart
controller = BoardController(
    totalRows: 5,
    totalColumns: 5,
);
```

### Display the board

```dart
GameBoard<int>(
    controller: boardController,
    onCellTap: (boardCell) => print('tapped cell: $boardCell'),
    cellBuilder: (boardCell) {
        return Text('${boardCell.data}');
    },
),
```

### Complete example

```dart
@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Board"),
      ),
      body: Center(
          child: GameBoard<int>(
            controller: boardController,
            onCellTap: (boardCell) => print('tapped cell: $boardCell'),
            cellBuilder: (boardCell) {
                return Text('${boardCell.data}');
            },
        ),
      )
    );
}

```

