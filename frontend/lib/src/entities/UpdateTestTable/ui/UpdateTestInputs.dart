import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/s.dart';

import '../../../shared/models/TestUpdateModel.dart';

class UpdateTestInputs extends ConsumerStatefulWidget {
  const UpdateTestInputs({super.key});

  @override
  ConsumerState<UpdateTestInputs> createState() => _UpdateTestInputsState();
}

class _UpdateTestInputsState extends ConsumerState<UpdateTestInputs> {
  TestUpdateModel model = const TestUpdateModel();
  String testId = '';
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: S.of(context).login,
              ),
              onChanged: (value) => setState(() {
                final newModel = model.copyWith(login: value);
                model = newModel;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: S.of(context).password,
              ),
              onChanged: (value) => setState(() {
                final newModel = model.copyWith(password: value);
                model = newModel;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: S.of(context).testNumber,
              ),
              onChanged: (value) => setState(() {
                final newModel = model.copyWith(testId: value);
                model = newModel;
              }),
            ),
          ),
        ],
      );
}
