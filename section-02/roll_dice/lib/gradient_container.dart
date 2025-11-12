import 'package:flutter/material.dart';
import 'package:roll_dice/dice_roller.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

// const purple = Colors.purple[300]!;
// const deepPurple = Colors.deepPurple[700]!;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.colors});

  // Dart supports multiple constructors
  //   const GradientContainer.purple({
  //     super.key,
  //     this.colors = const [purple, deepPurple],
  //   });

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(child: const DiceRoller()),
    );
  }
}
