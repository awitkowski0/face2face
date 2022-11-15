import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:face2face/view_models/users_viewmodel.dart';

Future<void> takePicture(CameraController cameraController) async {
  await cameraController.takePicture().then((photo) async {
    await photo.readAsBytes().then((value) => createPhoto(value));
  });
}