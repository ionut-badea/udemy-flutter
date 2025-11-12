import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roll_dice/styled_text.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceNumber = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/dice-$currentDiceNumber.png', width: 200),
        // This is a solution to increase distance between widgets
        // const SizedBox(height: 20),
        TextButton(
          onPressed: onPressHandler,
          style: TextButton.styleFrom(padding: const EdgeInsets.only(top: 20)),
          child: StyledText('Roll'),
        ),
      ],
    );
  }

  onPressHandler() {
    setState(() {
      currentDiceNumber = randomizer.nextInt(6) + 1;
    });
  }
}
