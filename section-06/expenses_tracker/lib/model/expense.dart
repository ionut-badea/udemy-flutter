import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final dateFormatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

IconData categoryIcons(Category category) {
  switch (category) {
    case Category.food:
      return Icons.restaurant;
    case Category.travel:
      return Icons.flight;
    case Category.leisure:
      return Icons.movie;
    case Category.work:
      return Icons.work;
  }
}

class Expense {
  final String id;

  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = _uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }

  IconData get iconByCategory {
    switch (category) {
      case Category.food:
        return Icons.restaurant;
      case Category.travel:
        return Icons.flight;
      case Category.leisure:
        return Icons.movie;
      case Category.work:
        return Icons.work;
    }
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses
          .where((expense) => expense.category == category)
          .toList();

  double get total {
    double value = 0;

    if (expenses.isNotEmpty) {
      value = expenses
          .map((expense) => expense.amount)
          .reduce((prev, next) => prev + next);
    }

    return value;
  }
}
