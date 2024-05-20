import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/TestResultsTable/ui/TestResultsTable.dart';
import '../../features/TestResultsActions/ui/TestResultsActions.dart';
import '../../shared/theme/Theme.dart';

@RoutePage()
class TestResultsScreen extends ConsumerWidget {
  const TestResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = TopGTheme.of(context).settings;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: const Column(
        children: [TestResultsTable(), TestResultsActions()],
      ),
    );
  }
}
