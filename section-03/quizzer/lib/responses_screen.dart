import 'package:flutter/material.dart';
import 'package:quizzer/data/questions.dart';
import 'package:quizzer/model/summary.dart';
import 'package:quizzer/responses_list.dart';

class ResponsesScreen extends StatefulWidget {
  const ResponsesScreen({
    super.key,
    required this.selectedAnswers,
    required this.restartQuiz,
  });

  final void Function() restartQuiz;
  final List<String> selectedAnswers;

  @override
  State<StatefulWidget> createState() {
    return _ResponsesScreenState();
  }
}

class _ResponsesScreenState extends State<ResponsesScreen> {
  List<Summary> get summary {
    final List<Summary> summary = [];

    for (var i = 0; i < questions.length; i++) {
      final question = questions[i];
      summary.add(
        Summary(
          index: i,
          question: question.text,
          correctAnswer: question.answers[0],
          selectedAnswer: widget.selectedAnswers[i],
          isCorrect: question.answers[0] == widget.selectedAnswers[i],
        ),
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final correctAnswers = summary.where((item) => item.isCorrect).length;

    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Center(
        child: Column(
          children: [
            Text(
              'You answered $correctAnswers out of ${questions.length} questions correctly!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 24),
            ResponsesList(summary: summary),
            SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                widget.restartQuiz();
              },
              child: Text(
                'Restart Quiz',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
