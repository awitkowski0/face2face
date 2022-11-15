import 'package:camera/camera.dart';
import 'package:face2face/view_models/chatViewModel.dart';
import 'package:face2face/view_models/authentication_viewmodel.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:face2face/views/main_view.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

=======
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'dart:async';
import 'package:path/path.dart';
>>>>>>> Stashed changes

// TODO:  do this better
late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) =>
  {
    authenticateAccount(),
    populateUsers()
  });

  _cameras = await availableCameras();
  runApp(ChangeNotifierProvider<ChatViewModel>(
    child: const MyApp(),
    create: (_) => ChatViewModel(), // Create a new ChangeNotifier object
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'face2face',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(cameras: _cameras),
      );
  }
}