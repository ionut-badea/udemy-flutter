import 'package:flutter/material.dart';

class Response extends StatelessWidget {
  const Response({
    super.key,
    required this.index,
    required this.question,
    required this.correctAnswer,
    required this.isCorrect,
    this.selectedAnswer,
  });

  final int index;
  final String question;
  final String correctAnswer;
  final bool isCorrect;
  final String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCorrect ? Colors.green : Colors.deepOrange,
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            '$index',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
        SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                '$selectedAnswer',
                style: TextStyle(color: Colors.amber, fontSize: 14),
              ),
              Text(
                correctAnswer,
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
