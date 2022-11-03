import 'package:camera/camera.dart';
import 'package:face2face/models/user_model.dart';
import 'package:face2face/view_model/viewModel.dart';
import 'package:face2face/views/main_view.dart';
import 'package:face2face/views/registration_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO:  do this better
late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(ChangeNotifierProvider<ChatViewModel>(
    child: MyApp(),
    create: (_) => ChatViewModel(), // Create a new ChangeNotifier object
  ));
}

final User _user = User(
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
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return MaterialApp(
        title: 'Face2Face',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const RegistrationPage(title: 'Registration'),
      );
    } else {
      return MaterialApp(
        title: 'face2face',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(cameras: _cameras),
      );
    }
  }
}