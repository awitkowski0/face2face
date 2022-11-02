import 'package:camera/camera.dart';
import 'package:face2face/models/user_model.dart';
import 'package:face2face/views/main_view.dart';
import 'package:face2face/views/registration_page_view.dart';
import 'package:flutter/material.dart';
import 'package:face2face/view/Account.dart';
import 'package:face2face/view/Login.dart';
import 'package:face2face/auth.dart';
import 'package:face2face/view/chat.dart';
import 'package:face2face/view/swipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'view/camera.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'model.dart';

// TODO:  do this better
late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const MyApp());
  _cameras = await availableCameras();
  runApp(MyApp());
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
  MyApp({Key? key});

  var routes = <String, WidgetBuilder>{
    IntoChat.routeName: (BuildContext context) => new IntoChat(),
    AccountPage.routeName: (BuildContext context) => new AccountPage(user: null),
    LoginForm.routeName: (BuildContext context) => new LoginForm(),
    MyHomePage.routeName: (BuildContext context) => new MyHomePage(cameras: _cameras)
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'face2face',
      theme: ThemeData(primarySwatch: Colors.red),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(cameras: _cameras),
      routes: routes
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required List<CameraDescription> cameras}) : super(key: key) {
    _cameras = cameras;
  }
  static final String routeName = "/home";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  bool _loggedIn = false;
  bool _noAccount = false;
  User user = User();
  final _formKey = GlobalKey<FormState>();
  final List<String> pages = <String>['Chat', 'Camera', 'Swipe'];

  @override
  Widget build(BuildContext context) {
    // Our navigation bar, should be universal for all pages
    Widget _buildNavigationBar() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swipe_outlined),
            label: '',
          ),
        ],
      );
    }

    // App bar for our application, should be the same on each screen
    PreferredSizeWidget _buildAppBar() {
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Text('${pages[_currentIndex]}'),
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => AccountPage(user: user)));
          },
        ),
        home: MyHomePage(cameras: _cameras),
      );
    }
    
    // Our body, should be different for each page
    Widget _buildBody() {
      switch (_currentIndex) {
        case 0:
          return ChatPage();
        case 2:
          return const SwipePage();
        default:
          return CameraPage(cameras: _cameras);
      }
    }
    // Main Application

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }
}