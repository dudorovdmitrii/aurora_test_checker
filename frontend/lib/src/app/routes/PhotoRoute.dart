import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/Camera/model/DeviceCameraModel.dart';
import '../../entities/Camera/ui/PhotoButton.dart';
import '../../entities/Settings/ui/Button.dart';
import '../../features/Camera/ui/Manager.dart';
import '../../features/CheckPhoto/libs/Notifier.dart';
import '../../shared/libs/log/log.dart';
import '../../shared/theme/Theme.dart';
import '../di/di.dart';
import '../di/photo_test_di.dart';
import 'AppRouter/AppRouter.dart';

@RoutePage()
class PhotoScreen extends ConsumerStatefulWidget {
  const PhotoScreen({super.key});

  @override
  ConsumerState<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends ConsumerState<PhotoScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  StreamSubscription<DeviceCameraModel>? _subscription;
  String description = '';
  FlashMode flashMode = FlashMode.always;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final camerasManager = getIt.get<CamerasManager>();
    _subscription ??= camerasManager.stream.listen(_onCamerasMangerEvent);
  }

  void _onCamerasMangerEvent(DeviceCameraModel cameraModel) =>
      cameraModel.when<void>(
        available: (cameras) {
          CameraDescription cameraDesc = cameras.first;
          for (final camera in cameras) {
            if (camera.lensDirection == CameraLensDirection.back) {
              cameraDesc = camera;
              break;
            }
          }
          unawaited(onNewCameraSelected(cameraDesc));
          setState(() {});
        },
        empty: () {
          description = 'No cameras available';
          setState(() {});
        },
        rejected: () {
          description = 'Press to give permission to the camera';
          setState(() {});
        },
        error: (message) {
          description = 'Error';
          setState(() {});
        },
        idle: () {
          description = 'Loading...';
          setState(() {});
        },
      );

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      return controller!.setDescription(cameraDescription);
    } else {
      return _initializeCameraController(cameraDescription);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      unawaited(cameraController.dispose());
    } else if (state == AppLifecycleState.resumed) {
      unawaited(_initializeCameraController(cameraController.description));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TopGTheme.of(context).settings;
    final notifier = ref.watch(PhotoTestDi.photoCheckProvider.notifier);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              child: _cameraPreviewWidget(),
            ),
          ),
          const SizedBox(height: 15),
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: PhotoButton(
                      onPressed: controller != null &&
                              controller!.value.isInitialized &&
                              !controller!.value.isRecordingVideo
                          ? () async =>
                              onTakePictureButtonPressed(context, notifier)
                          : null,
                    ),
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
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return GestureDetector(
        child: Text(
          description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        onTap: () async {
          final camerasManager = getIt.get<CamerasManager>();
          final cameras = await availableCameras();
          camerasManager.updateCameras(cameras);
        },
      );
    } else {
      return CameraPreview(
        controller!,
      );
    }
  }

  Future<void> onTakePictureButtonPressed(
      BuildContext context, PhotoCheckNotifier photoCheckNotifier) async {
    await takePicture().then(
      (XFile? file) async {
        if (mounted) {
          if (file != null) {
            getIt.get<Log>().d(file.path);
            photoCheckNotifier.checkPhoto(file.path);
            final camerasManager = getIt.get<CamerasManager>();
            camerasManager.turnOff();
            await context.router.push(const PhotoCheckRoute());
          }
        }
      },
    );
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      _showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      getIt.get<Log>().e('Error: ${e.code}\n${e.description}');
      _showInSnackBar('Error: ${e.code}\n${e.description}');
      return null;
    }
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        _showInSnackBar(
          'Camera error ${cameraController.value.errorDescription}',
        );
      }
    });

    await cameraController.initialize();
    await cameraController.setFlashMode(FlashMode.off);

    if (mounted) {
      setState(() {});
    }
  }

  void _showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await _subscription?.cancel();
    super.dispose();
  }
}
