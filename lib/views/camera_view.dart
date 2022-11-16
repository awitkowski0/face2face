import 'package:camera/camera.dart';
import 'package:face2face/view_models/camera_viewmodel.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

class CameraPage extends StatefulWidget {
  CameraPage({Key? key, required List<CameraDescription> cameras})
      : super(key: key) {
    _cameras = cameras;
  }

  @override
  State<CameraPage> createState() => _CameraState();
}

class _CameraState extends State<CameraPage> {
  late CameraController controller;
  bool cameraInitialized = false;

  @override
  void initState() {
    if (_cameras.isNotEmpty) {
      controller = CameraController(_cameras.last, ResolutionPreset.veryHigh);

      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
        cameraInitialized = true;
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
            // TODO: Kill the application.
              print('User denied camera access.');
              break;
            default:
            // Crash the application.
              print('Handle other errors.');
              break;
          }
        }
      });
    } else {
      print('No cameras available.');
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is specific to the camera
    Widget _buildCameraPreview() {
      if (cameraInitialized == true && controller.value.isInitialized) {
        return Stack(
          children: [
            CameraPreview(controller),
            Align(
              alignment: Alignment.center,
              child: FloatingActionButton(
                onPressed: () {
                  takePicture(controller);
                },
                child: const Icon(Icons.camera),
              ),
            ),
          ]);
      } else {
      return const Center(
        child: Text('No camera available for this device...'));
      }
    }

    return _buildCameraPreview();
  }
}
