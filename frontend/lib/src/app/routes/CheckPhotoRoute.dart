import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n/s.dart';

import '../../features/CheckPhotoActions/ui/CheckPhotoActions.dart';
import '../../shared/theme/Theme.dart';
import '../di/photo_test_di.dart';

@RoutePage()
class PhotoCheckScreen extends ConsumerWidget {
  const PhotoCheckScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = TopGTheme.of(context).settings;
    final checkPhotoModel = ref.watch(PhotoTestDi.photoCheckProvider);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).connectionSettings),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: theme.backgroundColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: checkPhotoModel.maybeWhen(
              photo: (path) => Image.file(
                File(path),
                fit: BoxFit.fill,
              ),
              orElse: () => const Placeholder(),
            ),
          ),
          ActionsWidget()
        ],
      ),
    );
  }
}
