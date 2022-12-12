import 'package:camera/camera.dart';
import 'package:face2face/view_models/camera_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/photos.dart';
import '../palette/palette.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraState();
}

class _CameraState extends State<CameraPage> {
  late bool isInit = false;
  late CameraController cameraController;
  late CameraViewModel viewModel;
  late bool isPreviewReady = false;
  late String currentPhoto;

  @override
  void initState() {
    viewModel = Provider.of<CameraViewModel>(context, listen: false);

    if (!isInit) viewModel.init();

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
      isPreviewReady =
          Provider.of<CameraViewModel>(context, listen: true).isPreviewReady;
      currentPhoto =
          Provider.of<CameraViewModel>(context, listen: true).photoURL!;

      if (!isPreviewReady && cameraController.value.isInitialized) {
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
      } else if (isPreviewReady) {
        return buildSwipePreview(context, currentPhoto);
      } else {
        // TODO: display some sort of error message or reask the user for camera access
        return const Center(child: CircularProgressIndicator());
      }
    }

    return buildCameraPreview();
  }
}

Container buildSwipePreview(BuildContext context, String currentPhoto) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Palette.orchid, width: 5),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.95,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(currentPhoto, fit: BoxFit.cover)));
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
