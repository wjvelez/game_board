class BoardCell<T> {
  BoardCell({
    required this.columnIndex,
    required this.rowIndex,
    this.isSelected = false,
    this.data,
  });
  int rowIndex;
  int columnIndex;
  T? data;

  bool isSelected;

  BoardCell<T> select(bool value) {
    return copyWith(
      selected: value,
    );
  }

  BoardCell<T> copyWith({
    int? columnIndex,
    int? rowIndex,
    bool? selected,
    T? data,
  }) {
    return BoardCell<T>(
      columnIndex: columnIndex ?? this.columnIndex,
      rowIndex: rowIndex ?? this.rowIndex,
      data: data ?? this.data,
      isSelected: selected ?? isSelected,
    );
  }

  BoardCell<T> updateValue(T? value) {
    return BoardCell<T>(
      columnIndex: columnIndex,
      rowIndex: rowIndex,
      isSelected: isSelected,
      data: value,
    );
  }

  bool belongFirstDiag() => rowIndex == columnIndex;

  bool belongSecondDiag(int totalRows) => totalRows - 1 == (rowIndex + columnIndex);

  // TODO Add Radius Neighbors method!

  @override
  String toString() => '(row: $rowIndex, col: $columnIndex, selected: $isSelected, data: $data)';
}
