import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../CheckPhotoRoute.dart';
import '../PhotoRoute.dart';
import '../SettingsRoute.dart';
import '../TestResultsRoute.dart';
import '../UpdateTestRoute.dart';

part 'AppRouter.gr.dart';

@injectable
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: PhotoRoute.page, initial: true),
        AutoRoute(page: PhotoCheckRoute.page),
        AutoRoute(page: TestResultsRoute.page),
        AutoRoute(page: TestUpdateRoute.page),
      ];
}
