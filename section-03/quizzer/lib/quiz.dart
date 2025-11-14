import 'package:flutter/material.dart';
import 'package:quizzer/data/questions.dart';
import 'package:quizzer/layout.dart';
import 'package:quizzer/questions_screen.dart';
import 'package:quizzer/responses_screen.dart';
import 'package:quizzer/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  String activeScreen = 'start-screen';
  List<String> selectedAnswers = [];

  void startQuiz(String screen) {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void onSelectAnswer(String answer) {
    selectedAnswers.add(answer);

    if (questions.length == selectedAnswers.length) {
      setState(() {
        activeScreen = 'responses-screen';
      });
    }
  }

  void restartQuiz() {
    selectedAnswers = [];

    setState(() {
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(startQuiz);

    switch (activeScreen) {
      case 'start-screen':
        screenWidget = StartScreen(startQuiz);
        break;
      case 'questions-screen':
        screenWidget = QuestionsScreen(onSelectAnswer: onSelectAnswer);
        break;
      case 'responses-screen':
        screenWidget = ResponsesScreen(
          selectedAnswers: selectedAnswers,
          restartQuiz: restartQuiz,
        );
        break;
      default:
        screenWidget = StartScreen(startQuiz);
    }

    return MaterialApp(home: Layout(child: screenWidget));
  }
}
