import 'package:face2face/models/photos.dart';

/// Content page provides the content for the swipe card
///
/// This consists of a picture, name, bio, age, and distance
class UserAccount {
  // UUID
  final String uniqueKey;

  // Profile images, in order of preference
  final List<Photo>? photos;

  // User's display name / preferred name
  final String? displayName;

  // Shorthand bio
  final String? shortBio;

  // Optional major
  final String? major;

  // Optional occupation
  final String? occupation;

  // Optional pronouns
  final String? pronouns;

  // Distance from swiping user
  final double? distance;

  // Age of user
  final int? age;

  UserAccount({
    required this.uniqueKey,
    this.photos,
    this.displayName,
    this.shortBio,
    this.major,
    this.occupation,
    this.pronouns,
    this.age,
  }) : distance = 1.0;

  // distance should be calculated by zipcode or some other element stored in DB

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _userFromJson(json);

  Map<String, dynamic> toJson() => _userToJson(this);

  @override
  String toString() => 'User<$displayName>';
}

UserAccount _userFromJson(Map<String, dynamic> json) {
  return UserAccount(
    uniqueKey: json['uniqueKey'] as String,
    displayName: json['displayName'] as String ?? '',
    shortBio: json['shortBio'] as String ?? '',
    major: json['major'] as String ?? '',
    occupation: json['occupation'] as String ?? '',
    pronouns: json['pronouns'] as String ?? '',
    age: json['age'] as int ?? 18,
    photos: (json['photos'] as List<dynamic>)
            .map((dynamic e) => Photo.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _userToJson(UserAccount user) => {
      'uniqueKey': user.uniqueKey,
      'photos': _photoList(user.photos) ?? [],
      'displayName': user.displayName ?? '',
      'shortBio': user.shortBio ?? '',
      'major': user.major ?? '',
      'occupation': user.occupation ?? '',
      'pronouns': user.pronouns ?? '',
      'age': user.age ?? 18,
    };

List<Map<String, dynamic>>? _photoList(List<Photo>? photos) {
  if (photos == null) {
    return [];
  }
  final photoMap = <Map<String, dynamic>>[];
  for (var photo in photos) {
    photoMap.add(photo.toJson());
  }
  return photoMap;
}
