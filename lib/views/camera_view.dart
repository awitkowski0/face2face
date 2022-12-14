import 'dart:async';

import 'package:camera/camera.dart';
import 'package:face2face/palette/palette.dart';
import 'package:face2face/view_models/camera_viewmodel.dart';
import 'package:face2face/views/swipe_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/photos.dart';
import '../models/user.dart';
import '../view_models/swipe_viewmodel.dart';

class CameraPage extends StatefulWidget {
  static const String routeName = "/camera";

  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraState();
}

class _CameraState extends State<CameraPage> {
  late bool isInit = false;
  late CameraController cameraController;
  late CameraViewModel cameraViewModel;
  late SwipeViewModel swipeViewModel;
  late bool shouldPreview = false;
  late Photo? currentPhoto;

  @override
  void initState() {
    cameraViewModel = Provider.of<CameraViewModel>(context, listen: false);
    swipeViewModel = Provider.of<SwipeViewModel>(context, listen: false);

    if (!isInit) {
      cameraViewModel.init();
      swipeViewModel.forceUser();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is specific to the camera
    Widget buildCameraPreview() {
      cameraController =
          Provider.of<CameraViewModel>(context, listen: true).controller;
      shouldPreview =
          Provider.of<CameraViewModel>(context, listen: true).isPreviewReady;
      FlashMode flashMode =
          Provider.of<CameraViewModel>(context, listen: true).flashMode;
      UserAccount userAccount =
          Provider.of<CameraViewModel>(context, listen: true).getCurrentUser();
      currentPhoto =
          Provider.of<SwipeViewModel>(context, listen: true).currentPhoto;

      Icon flashIcon;

      if (flashMode == FlashMode.off) {
        flashIcon = const Icon(Icons.flash_off);
      } else {
        if (flashMode == FlashMode.auto) {
          flashIcon = const Icon(Icons.flash_auto);
        } else {
          flashIcon = const Icon(Icons.flash_on);
        }
      }
      if (!shouldPreview && cameraController.value.isInitialized) {
        cameraController.setFlashMode(flashMode);

        return Stack(children: [
          // Camera preview requires a controller
          Transform.scale(scale: 1.15, child: CameraPreview(cameraController)),
          buttons(context, flashIcon, false),
        ]);
      } else if (shouldPreview) {
        return preview(context, userAccount, currentPhoto!);
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }

    return buildCameraPreview();
  }
}

Widget buttons(BuildContext context, Icon flashIcon, bool cooldown) {
  if (cooldown) {
    return Column(children: const [
      Center(
        child: Icon(Icons.hourglass_bottom, size: 300, color: Palette.orchid),
      ),
      Text('You have used your selfie!'),
      Text('Come back in...')
    ]);
  } else {
    return camera(context, flashIcon);
  }
}

Widget camera(BuildContext context, Icon flashIcon) {
  return Column(
    children: [
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          width: MediaQuery.of(context).size.width),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CameraViewModel>().changeCameras();
            },
            child: const Icon(Icons.cached_outlined),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CameraViewModel>().takePicture();
            },
            child: const Icon(Icons.camera_outlined),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CameraViewModel>().switchFlash();
            },
            child: flashIcon,
          ),
        ],
      ),
    ],
  );
}

Widget preview(
    BuildContext context, UserAccount userAccount, Photo currentPhoto) {
  return Stack(children: [
    buildCardForUser(context, userAccount, false, currentPhoto),
    Column(children: [
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.675,
          width: MediaQuery.of(context).size.width),
      TextButton(
        onPressed: () {
          context.read<CameraViewModel>().discardPreview();
        },
        child: Container(
            height: 40,
            width: 350,
            decoration: BoxDecoration(
                color: Palette.pink, borderRadius: BorderRadius.circular(50)),
            child: const Text('Exit Preview',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
      ),
    ]),
  ]);
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
    default:
      throw ArgumentError('Unknown lens direction');
  }
}
