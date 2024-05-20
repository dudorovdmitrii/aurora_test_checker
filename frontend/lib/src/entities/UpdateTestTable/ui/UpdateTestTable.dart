import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/s.dart';

import '../../../features/Results/ui/TestTable.dart';
import '../../../shared/models/TestUpdateModel.dart';

class UpdateTestTable extends ConsumerStatefulWidget {
  const UpdateTestTable({super.key});

  @override
  ConsumerState<UpdateTestTable> createState() => _UpdateTestTableState();
}

class _UpdateTestTableState extends ConsumerState<UpdateTestTable> {
  TestUpdateModel model = const TestUpdateModel();
  String testId = '';
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TestTableRow(
              cells: [
                Text(
                  S.of(context).questionNumber,
                  textAlign: TextAlign.center,
                ),
                Text(
                  S.of(context).selectedAnswer,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          for (int i = 0; i < model.test.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TestTableRow(
                cells: [
                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) => setState(() {
                      final newList = <TestUpdateRowModel>[];
                      for (int j = 0; j < model.test.length; j++) {
                        String question = model.test[j].question;
                        if (i == j) {
                          question = value;
                        }
                        final newRow = TestUpdateRowModel(
                            question: question, answer: model.test[j].answer);
                        newList.add(newRow);
                      }
                      final newModel = model.copyWith(test: newList);
                      model = newModel;
                    }),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) => setState(() {
                      final newList = <TestUpdateRowModel>[];
                      for (int j = 0; j < model.test.length; j++) {
                        String answer = model.test[j].answer;
                        if (i == j) {
                          answer = value;
                        }
                        final newRow = TestUpdateRowModel(
                            question: model.test[j].question, answer: answer);
                        newList.add(newRow);
                      }
                      final newModel = model.copyWith(test: newList);
                      model = newModel;
                    }),
                  ),
                ],
              ),
            ),
        ],
      );
}
