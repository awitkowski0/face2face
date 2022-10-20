// This would actually be populated from the database
import 'package:face2face/models/user_model.dart';

final List<User> users = [
  User(
    images: const <String>[
      'assets/images/profiles/james0.jpeg',
      'assets/images/profiles/james1.jpeg',
      'assets/images/profiles/james2.jpeg',
      'assets/images/profiles/james3.jpeg',
    ],
    displayName: 'James',
    shortBio: 'I like to fish',
    major: 'Actuary Science',
    occupation: 'Student',
    pronouns: 'He/Him',
    age: 20,
  ),
  User(
    images: const <String>[
      'assets/images/profiles/chris0.jpeg',
      'assets/images/profiles/chris1.jpeg',
      'assets/images/profiles/chris2.jpeg',
      'assets/images/profiles/chris3.jpeg',
    ],
    displayName: 'Chris',
    shortBio: 'I like to code',
    major: 'Computer Science',
    occupation: 'Software Engineer',
    pronouns: 'He/Him',
    age: 21,
  ),
  User(
    images: const <String>[
      'assets/images/profiles/chase0.jpeg',
      'assets/images/profiles/chase1.jpeg',
      'assets/images/profiles/chase2.jpeg',
      'assets/images/profiles/chase3.jpeg',
    ],
    displayName: 'Chase',
    shortBio: 'I like to hike',
    major: 'Mechanical Engineering',
    occupation: 'Mechanic',
    pronouns: 'He/Him',
    age: 19,
  )
];