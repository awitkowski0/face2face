import 'package:camera/camera.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class CameraViewModel extends ChangeNotifier {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late bool isInitialized = false;

  void onChange() {
    notifyListeners();
  }

  // Initialize cameras and camera controller
  Future<void> init() async {
    _cameras = await availableCameras();

    if (_cameras.isNotEmpty) {
      _controller = CameraController(_cameras.last, ResolutionPreset.veryHigh);

      _controller.initialize().then((_) {
        isInitialized = true;

        return;
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
  }

  // Take a picture
  Future<void> takePicture() async {
    await _controller.takePicture().then((photo) async {
      await photo.readAsBytes().then((value) => createPhoto(value));
    });
  }
  CameraController get controller => _controller;
}