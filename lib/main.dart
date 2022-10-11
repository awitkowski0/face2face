import 'package:camera/camera.dart';
import 'package:face2face/chat.dart';
import 'package:face2face/swipe.dart';
import 'package:flutter/material.dart';

import 'camera.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'face2face',
      theme: ThemeData(primarySwatch: Colors.red),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(cameras: _cameras),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required List<CameraDescription> cameras}) : super(key: key) {
    _cameras = cameras;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;

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
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            // Respond to button press
          },
        ),
        actions: const <Widget>[],
      );
    }

    // Our body, should be different for each page
    Widget _buildBody() {
      switch (_currentIndex) {
        case 0:
          return const ChatPage();
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