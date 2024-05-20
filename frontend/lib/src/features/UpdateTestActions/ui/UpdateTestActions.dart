import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/di.dart';
import '../../../shared/libs/TestCheck.dart';
import '../../../shared/models/TestUpdateModel.dart';
import '../../../shared/theme/Theme.dart';

class UpdateTestActions extends ConsumerStatefulWidget {
  const UpdateTestActions({super.key});

  @override
  ConsumerState<UpdateTestActions> createState() => _UpdateTestActionsState();
}

class _UpdateTestActionsState extends ConsumerState<UpdateTestActions> {
  TestUpdateModel model = const TestUpdateModel();
  String testId = '';
  @override
  Widget build(BuildContext context) {
    final theme = TopGTheme.of(context).settings;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: theme.blockColor),
                  child: const Text('-'),
                  onPressed: () {
                    setState(() {
                      final newList = List<TestUpdateRowModel>.from(
                        model.test,
                        growable: true,
                      );
                      newList.removeLast();
                      final newModel = model.copyWith(test: newList);
                      model = newModel;
                    });
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: theme.blockColor),
                  child: const Text('+'),
                  onPressed: () {
                    setState(() {
                      final newList = List<TestUpdateRowModel>.from(
                        model.test,
                        growable: true,
                      );
                      newList.add(const TestUpdateRowModel());
                      final newModel = model.copyWith(test: newList);
                      model = newModel;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: OutlinedButton(
            child: const Text('Send'),
            onPressed: () async {
              await getIt.get<TestCheckService>().sendTest(model);
              // ignore: use_build_context_synchronously
              unawaited(context.router.maybePop());
            },
            style: OutlinedButton.styleFrom(foregroundColor: theme.blockColor),
          ),
        ),
      ],
    );
  }
}
