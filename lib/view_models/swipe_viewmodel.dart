import 'package:face2face/models/photos.dart';
import 'package:face2face/models/user.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class SwipeViewModel extends ChangeNotifier {
  late List<UserAccount> potentialMatches;
  late UserAccount currentUser;
  late int index;
  late List<Photo> currentUserPhotos;
  late Photo currentPhoto;
  late int photoIndex;

  Future<void> init() async {
    potentialMatches = users;
    currentUser = potentialMatches[0];
    currentUserPhotos = currentUser.photos!;
    currentPhoto = currentUserPhotos[0];
    photoIndex = 0;
    index = 0;
  }

  Future<void> likeUser() async {
    nextUser();
    // TODO: match storing
  }
  Future<void> dislikeUser() async {
    nextUser();
    // TODO: not matching
  }
  Future<void> nextUser() async {
    if (potentialMatches.length > (index + 1)) {
      currentUser = potentialMatches[index + 1];
      currentUserPhotos = currentUser.photos!;
      index += 1;
      notifyListeners();
    }
    // TODO: add a condition if there's none
    // TODO: add an "end of stack" card
  }
  Future<void> lastPhoto() async {
    if (currentUserPhotos.isNotEmpty && currentUserPhotos.length > (photoIndex - 1)) {
      currentPhoto = currentUserPhotos[photoIndex - 1];
      photoIndex -= 1;
      notifyListeners();
    }
  }
  Future<void> nextPhoto() async {
    if (currentUserPhotos.isNotEmpty && currentUserPhotos.length > (photoIndex + 1)) {
      currentPhoto = currentUserPhotos[photoIndex + 1];
      photoIndex += 1;
      notifyListeners();
    }
  }
}