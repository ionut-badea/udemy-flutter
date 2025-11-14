import 'package:flutter/material.dart';
import 'package:quizzer/answer_button.dart';
import 'package:quizzer/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final Function(String answer) onSelectAnswer;

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;

  void onPressHandler(String answer) {
    widget.onSelectAnswer(answer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            questions[currentQuestionIndex].text,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 24),
          for (var answer in questions[currentQuestionIndex].shuffledAnswers)
            AnswerButton(
              answer: answer,
              onPressedHandler: () {
                onPressHandler(answer);
              },
            ),
        ],
      ),
    );
  }
}
