import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answer;

  final Function() onPressedHandler;
  const AnswerButton({
    super.key,
    required this.answer,
    required this.onPressedHandler,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedHandler,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        answer,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}
