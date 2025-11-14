import 'package:flutter/material.dart';
import 'package:quizzer/model/summary.dart';
import 'package:quizzer/response.dart';

class ResponsesList extends StatelessWidget {
  const ResponsesList({super.key, required this.summary});

  final List<Summary> summary;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            for (var item in summary)
              Response(
                index: item.index + 1,
                question: item.question,
                correctAnswer: item.correctAnswer,
                isCorrect: item.isCorrect,
                selectedAnswer: item.selectedAnswer,
              ),
          ],
        ),
      ),
    );
  }
}
