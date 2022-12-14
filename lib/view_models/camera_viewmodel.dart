import 'dart:async';

import 'package:camera/camera.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:flutter/cupertino.dart';

import '../models/photos.dart';

class CameraViewModel extends ChangeNotifier {
  late bool isPreviewReady = false;
  late final List<CameraController> _cameras = [];
  late CameraController controller;
  late int _currentCamera = 0;
  late FlashMode flashMode = FlashMode.off;
  late Timer timer;

  // Initialize cameras and camera controller
  Future<void> init() async {
    _currentCamera = 0;

    await availableCameras()
        .then((value) => {
              value.forEach((element) {
                _cameras.add(CameraController(element, ResolutionPreset.high));
              })
            })
        .then((value) => {
              controller = _cameras[_currentCamera],
              controller.initialize().then((value) => notifyListeners())
            });
  }

  getLastPhotoTime() {
    return users[0].photos![0].createdAt;
  }

  getCurrentUser() {
    return getAccountUser();
  }

  Photo getCurrentPhoto() {
    return getAccountUser().photos!.last;
  }

  Future<void> switchFlash() async {
    if (flashMode == FlashMode.off) {
      flashMode = FlashMode.always;
    } else if (flashMode == FlashMode.always) {
      flashMode = FlashMode.off;
    } else {
      flashMode = FlashMode.auto;
    }
    notifyListeners();
  }

  // Change the camera you have open
  Future<void> changeCameras() async {
    if (_cameras.isNotEmpty && _cameras.length > (_currentCamera + 1)) {
      controller = _cameras[_currentCamera + 1];
      _currentCamera++;
    } else {
      controller = _cameras[0];
      _currentCamera = 0;
    }
    controller.initialize().then((value) => notifyListeners());
  }

  Future<void> discardPreview() async {
    isPreviewReady = false;
    notifyListeners();
  }

  // Take a picture
  Future<void> takePicture() async {
    await controller.takePicture().then((photo) async {
      await photo.readAsBytes().then((value) => {
            createPhoto(value)
                .then((value) => {isPreviewReady = true, notifyListeners()}),
          });
    });
  }
}
