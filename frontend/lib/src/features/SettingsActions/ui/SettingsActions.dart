import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routes/AppRouter/AppRouter.dart';
import '../../../shared/theme/Theme.dart';

class SettingsActionsActions extends ConsumerStatefulWidget {
  const SettingsActionsActions({super.key});

  @override
  ConsumerState<SettingsActionsActions> createState() =>
      _SettingsActionsActionsState();
}

class _SettingsActionsActionsState
    extends ConsumerState<SettingsActionsActions> {
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
            alignment: AlignmentDirectional.centerEnd,
            child: OutlinedButton(
              onPressed: () async {
                await context.router.push(const TestUpdateRoute());
              },
              style:
                  OutlinedButton.styleFrom(foregroundColor: theme.blockColor),
              child: const Text('Добавить тест'),
            ),
          )
        ],
      ),
    );
  }
}
