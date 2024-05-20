import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:i18n/s.dart';

import '../../entities/UpdateTestTable/ui/UpdateTestInputs.dart';
import '../../entities/UpdateTestTable/ui/UpdateTestTable.dart';
import '../../features/UpdateTestActions/ui/UpdateTestActions.dart';
import '../../shared/models/TestUpdateModel.dart';
import '../../shared/theme/Theme.dart';

@RoutePage()
class TestUpdateScreen extends StatefulWidget {
  const TestUpdateScreen({super.key});

  @override
  State<TestUpdateScreen> createState() => _TestUpdateScreenState();
}

class _TestUpdateScreenState extends State<TestUpdateScreen> {
  TestUpdateModel model = const TestUpdateModel();
  @override
  Widget build(BuildContext context) {
    final theme = TopGTheme.of(context).settings;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        title: Text(S.of(context).updatingTheTests),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            UpdateTestInputs(),
            SizedBox(height: 10),
            UpdateTestTable(),
            SizedBox(height: 10),
            UpdateTestActions()
          ],
        ),
      ),
    );
  }
}
