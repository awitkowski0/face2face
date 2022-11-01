import 'package:camera/camera.dart';
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
      controller = CameraController(_cameras.first, ResolutionPreset.veryHigh);

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
        return AspectRatio(
          aspectRatio: controller.value.aspectRatio * 0.28,
          child: CameraPreview(controller),
        );
      } else {
        return const Center(
            child: Text('No camera available for this device...'));
      }
    }

    return _buildCameraPreview();
  }
}
