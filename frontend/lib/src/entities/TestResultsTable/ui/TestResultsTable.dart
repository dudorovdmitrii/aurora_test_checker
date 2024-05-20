import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/s.dart';

import '../../../app/di/photo_test_di.dart';
import '../../../features/Results/ui/TestResults.dart';
import '../../../shared/models/TestUpdateModel.dart';
import '../../../widgets/TestParameters/ui/TestParameters.dart';

class TestResultsTable extends ConsumerStatefulWidget {
  const TestResultsTable({super.key});

  @override
  ConsumerState<TestResultsTable> createState() => _TestResultsTableState();
}

class _TestResultsTableState extends ConsumerState<TestResultsTable> {
  TestUpdateModel model = const TestUpdateModel();
  String testId = '';
  @override
  Widget build(BuildContext context) {
    final results = ref.watch(PhotoTestDi.testResultsProvider);

    return Expanded(
        child: Center(
      child: results.map(
        results: (results) => TestResultsWidget(
          answers: results.answersList,
          correctAnswers: results.correctAnswers,
          incorrectAnswers: results.incorrectAnswers,
        ),
        loading: (_) => const Center(child: CircularProgressIndicator()),
        error: (error) => Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            child: Text('${S.of(context).error}: ${error.message}')),
        bad: (_) => Center(child: Text('Try again')),
        parameters: (_) => const Center(
          child: TestParametersWidget(),
        ),
      ),
    ));
  }
}
