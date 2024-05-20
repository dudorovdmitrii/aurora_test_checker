import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routes/AppRouter/AppRouter.dart';
import '../../../entities/Settings/ui/Button.dart';
import '../../../shared/theme/Theme.dart';

class TestResultsActions extends ConsumerStatefulWidget {
  const TestResultsActions({super.key});

  @override
  ConsumerState<TestResultsActions> createState() => _TestResultsActionsState();
}

class _TestResultsActionsState extends ConsumerState<TestResultsActions> {
  String testId = '';
  @override
  Widget build(BuildContext context) {
    final theme = TopGTheme.of(context).settings;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              onPressed: () {
                unawaited(context.router.maybePop());
              },
              icon: Icon(
                size: 40,
                Icons.chevron_left,
                color: theme.blockColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SettingsButton(
              onTap: () async {
                await context.router.push(const SettingsRoute());
              },
            ),
          )
        ],
      ),
    );
  }
}
