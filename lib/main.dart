import 'package:face2face/palette/palette.dart';
import 'package:face2face/view_models/accounts_viewmodel.dart';
import 'package:face2face/view_models/authentication_viewmodel.dart';
import 'package:face2face/view_models/camera_viewmodel.dart';
import 'package:face2face/view_models/chat_viewmodel.dart';
import 'package:face2face/view_models/swipe_viewmodel.dart';
import 'package:face2face/view_models/users_viewmodel.dart';
import 'package:face2face/views/account_view.dart';
import 'package:face2face/views/main_view.dart';
import 'package:face2face/views/welcome_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => populateUsers());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthenticationViewModel()),
          ChangeNotifierProvider(create: (_) => AccountViewModel()),
          ChangeNotifierProvider(create: (_) => ChatViewModel()),
          ChangeNotifierProvider(create: (_) => CameraViewModel()),
          ChangeNotifierProvider(create: (_) => SwipeViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'face2face',
          theme: ThemeData(
            primarySwatch: Palette.orchid,
          ),
          routes: {
            MyHomePage.routeName: (context) => const MyHomePage(),
            WelcomePage.routeName: (context) => const WelcomePage(),
            AccountPage.routeName: (context) => const AccountPage(),
          },
        ));
  }
}
