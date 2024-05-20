import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/s.dart';

import '../../../app/di/di.dart';
import '../../../app/di/photo_test_di.dart';
import '../../../app/routes/AppRouter/AppRouter.dart';
import '../../../entities/Settings/ui/Button.dart';
import '../../../features/Camera/ui/Manager.dart';
import '../../../shared/theme/Theme.dart';

class ActionsWidget extends ConsumerStatefulWidget {
  const ActionsWidget({super.key});

  @override
  ConsumerState<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends ConsumerState<ActionsWidget> {
  String testId = '';
  @override
  Widget build(BuildContext context) {
    void handleGoBack() {
      final manager = getIt.get<CamerasManager>();
      unawaited(manager.getAvailableCameras());
      unawaited(context.router.maybePop());
    }

    final theme = TopGTheme.of(context).settings;
    final notifier = ref.watch(PhotoTestDi.testResultsProvider.notifier);
    final photoCheckModel = ref.watch(PhotoTestDi.photoCheckProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style:
                  OutlinedButton.styleFrom(foregroundColor: theme.blockColor),
              child: Text(S.of(context).remake),
              onPressed: handleGoBack,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: OutlinedButton(
              style:
                  OutlinedButton.styleFrom(foregroundColor: theme.blockColor),
              child: Text(S.of(context).continuE),
              onPressed: photoCheckModel.maybeMap(
                orElse: () => () {},
                photo: (photo) => () {
                  notifier.setPath(photo.path);
                  unawaited(
                    context.router.push(const TestResultsRoute()),
                  );
                },
              ),
            ),
          ),
          SettingsButton(
            onTap: () async {
              await context.router.push(const SettingsRoute());
            },
          ),
        ],
      ),
    );
  }
}
