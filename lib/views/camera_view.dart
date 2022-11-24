import 'package:camera/camera.dart';
import 'package:face2face/view_models/camera_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraState();
}

class _CameraState extends State<CameraPage> {
  late bool isInit = false;
  late CameraController cameraController;
  late CameraViewModel viewModel;

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
      isInit = Provider.of<CameraViewModel>(context, listen: true).isInitialized;
      if (isInit) {
        cameraController =
            Provider.of<CameraViewModel>(context, listen: false).controller;
      }

      if (isInit && cameraController.value.isInitialized) {
        print('Camera is initialized');

        return Stack(children: [
          // Camera preview requires a controller
          CameraPreview(cameraController),
          Align(
            alignment: Alignment.center,
            child: FloatingActionButton(
              onPressed: () {
                context.read<CameraViewModel>().takePicture();
              },
              child: const Icon(Icons.camera),
            ),
          ),
        ]);
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }

    return buildCameraPreview();
  }
}
