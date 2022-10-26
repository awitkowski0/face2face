import 'package:camera/camera.dart';
import 'package:face2face/Account.dart';
import 'package:face2face/chat.dart';
import 'package:face2face/swipe.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'camera.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'User.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'app_database.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    version: 1
  );

  Future<void> insertUser(User user) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the User into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same usere is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> users() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Users.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }
  
  var matt = new User(id: 0, name: "Matt", age: 21);
  await insertUser(matt);

  List<User> us = await users();
  print(await users());

  _cameras = await availableCameras();
  runApp(MyApp(user: us.elementAt(0)));
}

class MyApp extends StatelessWidget {
  final User? user;
  MyApp({Key? key, this.user});

  var routes = <String, WidgetBuilder>{
    IntoChat.routeName: (BuildContext context) => new IntoChat(),
    AccountPage.routeName: (BuildContext context) => new AccountPage()
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

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
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
            Navigator.pushNamed(context, AccountPage.routeName);
          },
        ),
        actions: const <Widget>[],
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