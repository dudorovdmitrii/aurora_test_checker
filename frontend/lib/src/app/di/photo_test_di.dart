import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/CheckPhoto/libs/Notifier.dart';
import '../../features/CheckPhoto/model/PhotoCheckModel.dart';
import '../../features/Results/libs/Notifier.dart';
import '../../features/Results/model/TestResultsModel.dart';
import '../../shared/libs/TestCheck.dart';
import 'di.dart';

abstract class PhotoTestDi {
  static final photoCheckProvider =
      StateNotifierProvider.autoDispose<PhotoCheckNotifier, PhotoCheckModel>(
    (ref) => PhotoCheckNotifier(),
  );

  static final testResultsProvider =
      StateNotifierProvider.autoDispose<TestResultsNotifier, TestResultsModel>(
    (ref) => TestResultsNotifier(
      testCheckService: getIt.get<TestCheckService>(),
    ),
  );
}
