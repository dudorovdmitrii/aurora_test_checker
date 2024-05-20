import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/libs/TestCheck.dart';
import '../model/TestResultsModel.dart';

class TestResultsNotifier extends StateNotifier<TestResultsModel> {
  final TestCheckService _testCheckService;
  TestResultsNotifier({
    required TestCheckService testCheckService,
  })  : _testCheckService = testCheckService,
        super(const TestResultsModel.loading());

  Future<void> sendPhoto({
    required String path,
    required String testId,
  }) async {
    final model = await _testCheckService.sendPhoto(path: path, testId: testId);
    state = model as TestResultsModel;
  }

  void setPath(String path) => state = TestResultsModel.parameters(path: path);

  void toLoading() => state = const TestResultsModel.loading();
}
