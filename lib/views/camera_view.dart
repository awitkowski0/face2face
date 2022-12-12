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
  late Photo currentPhoto;

  @override
  void initState() {
    cameraViewModel = Provider.of<CameraViewModel>(context, listen: false);
    swipeViewModel = Provider.of<SwipeViewModel>(context, listen: false);

    if (!isInit) {
      cameraViewModel.init();
      swipeViewModel.init();
      print('user: ' + cameraViewModel.getCurrentUser().toString());
      swipeViewModel.forceUser(cameraViewModel.getCurrentUser());
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
      UserAccount userAccount =
          Provider.of<CameraViewModel>(context, listen: true).getCurrentUser();
      Photo photo =
          Provider.of<CameraViewModel>(context, listen: true).getCurrentPhoto();

      if (!shouldPreview && cameraController.value.isInitialized) {
        cameraController.setFlashMode(FlashMode.always);
        cameraController.setFocusMode(FocusMode.auto);
        cameraController.setZoomLevel(0.5);

        return Stack(children: [
          // Camera preview requires a controller
          CameraPreview(cameraController,
              child: Align(
                  // move to a separate stack, we'll set the camera preview as the backround image and the run a column over the stack
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          context.read<CameraViewModel>().takePicture();
                        },
                        child: const Icon(Icons.camera_outlined),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          context.read<CameraViewModel>().changeCameras();
                        },
                        child: const Icon(Icons.cached_outlined),
                      ),
                    ],
                  ))),
        ]);
      } else if (shouldPreview) {
        return Stack(children: [
          buildCardForUser(context, userAccount, false, photo),
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
                      color: Palette.pink,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text('Exit Preview',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
            ),
          ]),
        ]);
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }

    return buildCameraPreview();
  }
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
