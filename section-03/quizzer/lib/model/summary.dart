class Summary {
  Summary({
    required this.index,
    required this.question,
    required this.correctAnswer,
    required this.selectedAnswer,
    required this.isCorrect,
  });

  final int index;
  final String question;
  final String correctAnswer;
  final String selectedAnswer;
  final bool isCorrect;
}
