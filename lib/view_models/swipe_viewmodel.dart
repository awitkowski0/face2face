import 'package:face2face/models/photos.dart';
import 'package:face2face/models/user.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:flutter/cupertino.dart';

class SwipeViewModel extends ChangeNotifier {
  late List<UserAccount> potentialMatches = [];
  late UserAccount currentUser;
  late int index;
  late List<Photo> currentUserPhotos;
  late Photo? currentPhoto = null;
  late int photoIndex;
  late List<UserAccount> dislikedUsers = [];
  late List<UserAccount> likedUsers = [];
  late bool endOfStack = false;
  late bool isPhotoReady = false;

  Future<void> init() async {
    potentialMatches = users;
    currentUser = potentialMatches[0];
    currentUserPhotos = currentUser.photos!;
    currentPhoto = currentUserPhotos[0];
    photoIndex = 0;
    index = 0;
  }

  Future<void> forceUser() async {
    currentUser = getAccountUser();

    if (currentUser.photos != null) {
      currentUserPhotos = currentUser.photos!;
      currentPhoto = currentUserPhotos[0];
    } else {
      currentUserPhotos = [];
      currentPhoto = null;
    }
    photoIndex = 0;
    index = 0;
    notifyListeners();
  }

  Future<void> likeUser() async {
    likedUsers.add(currentUser);
    nextUser();
    // TODO: match storing
  }

  Future<void> dislikeUser() async {
    dislikedUsers.add(currentUser);
    nextUser();
    // TODO: not matching
  }

  Future<void> nextUser() async {
    if (potentialMatches.length > (index + 1)) {
      currentUser = potentialMatches[index + 1];
      currentUserPhotos = currentUser.photos!;
      currentPhoto = currentUserPhotos[0];
      index += 1;
    } else {
      endOfStack = true;
    }
    notifyListeners();
  }

  Future<void> lastPhoto() async {
    if (currentUserPhotos.isNotEmpty &&
        currentUserPhotos.length > (photoIndex - 1)) {
      currentPhoto = currentUserPhotos[photoIndex - 1];
      photoIndex -= 1;
      notifyListeners();
    }
  }

  Future<void> nextPhoto() async {
    if (currentUserPhotos.isNotEmpty &&
        currentUserPhotos.length > (photoIndex + 1)) {
      currentPhoto = currentUserPhotos[photoIndex + 1];
      photoIndex += 1;
      notifyListeners();
    }
  }
}
