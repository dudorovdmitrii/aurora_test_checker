import 'package:flutter/material.dart';

import '../model/TestResultsModel.dart';
import 'TestTable.dart';

class TestResultsWidget extends StatelessWidget {
  final List<TestAnswerModel> answers;
  final int correctAnswers;
  final int incorrectAnswers;
  const TestResultsWidget({
    required this.answers,
    required this.correctAnswers,
    required this.incorrectAnswers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final score = correctAnswers == 0 && incorrectAnswers == 0
        ? 0.0
        : (correctAnswers / (correctAnswers + incorrectAnswers) * 100).round();

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: Center(
                  child: Text(
                    '$score%',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const TestTableRow(
                cells: [
                  Text(
                    'Question number',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Selected answer',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Right answer',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              for (final answer in answers)
                TestTableRow(
                  cells: [
                    Text(
                      answer.question,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      answer.answer,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      answer.correctAnswer,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
