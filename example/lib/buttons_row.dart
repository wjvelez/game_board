import 'package:example/demo_button.dart';
import 'package:example/game_board_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameBoardViewProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: DemoButton(
              label: 'Zeros',
              onTap: () {
                provider.fillWithValue(0);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DemoButton(
              label: 'Ones',
              onTap: () {
                provider.fillWithValue(1);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DemoButton(
              label: 'Ramdon',
              onTap: () {
                provider.fillRamdon();
              },
            ),
          ),
        ],
      ),
    );
  }
}
