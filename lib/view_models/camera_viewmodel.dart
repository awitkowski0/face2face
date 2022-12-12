import 'dart:collection';

import 'package:camera/camera.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class CameraViewModel extends ChangeNotifier {
  late final List<CameraController> _cameras = [];
  late CameraController controller;
  late bool isInitialized = false;

  Future<void> changeCameras() async {
    if (_cameraMap.length > 1) {
      notifyListeners();
    }
  }

  // Initialize cameras and camera controller
  Future<void> init() async {
    await availableCameras().then((value) => {
      value.forEach((element) {
        _cameraMap[element] = CameraController(element, ResolutionPreset.medium);
        isInitialized = true;
      })
    }).then((value) => notifyListeners());

    if (_cameraMap.isNotEmpty && !isInitialized) {
      // we specify the camera we want to use here, and the resolution to it
      controller = CameraController(_cameras.last, ResolutionPreset.veryHigh);

      controller.initialize().then((_) {
        isInitialized = true;
        notifyListeners();
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
    await controller.takePicture().then((photo) async {
      await photo.readAsBytes().then((value) => createPhoto(value));
    });
  }
}
