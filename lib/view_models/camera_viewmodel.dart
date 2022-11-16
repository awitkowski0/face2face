import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:face2face/models/user_model.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> takePicture(CameraController cameraController) async {
  await cameraController.takePicture().then((photo) async {
    await photo.readAsBytes().then((value) => createPhoto(value));
  });
}

Uint8List getUserPhoto(UserAccount userAccount) {
  final photo = userAccount.photos?.first;
  final storageRef = FirebaseStorage.instance.ref();
  final photoRef = storageRef.child("images/{$photo?.id}");

  try {
    photoRef.getData().then((value) {
      return value;
    });
  } on FirebaseException catch (e) {
    // Handle any errors.
  }
  return Uint8List(0);
}
