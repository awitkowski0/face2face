import 'package:face2face/view_models/accounts_viewmodel.dart';
import 'package:face2face/views/authentication_view.dart';
import 'package:face2face/views/swipe_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'camera_view.dart';
import 'chat_view.dart';
import 'package:face2face/palette/palette.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<String> pages = <String>['Chat', 'Camera', 'Swipe'];

  @override
  void initState() {
    Provider.of<AccountViewModel>(context, listen: false).init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Progress indicator while things are still loading...
    Widget buildProgressIndicator() {
      return const Center(child: CircularProgressIndicator());
    }

    // Our navigation bar, should be universal for all pages
    Widget buildNavigationBar() {
      return BottomNavigationBar(
        selectedItemColor: Palette.orchid,
        backgroundColor: Palette.orange[200],
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
    PreferredSizeWidget buildAppBar() {
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(pages[_currentIndex]),
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Provider.of<AccountViewModel>(context, listen: false).signOut();
            // Respond to button press
          },
        ),
        actions: const <Widget>[],
      );
    }

    // Our body, should be different for each page
    Widget buildBody() {
      switch (_currentIndex) {
        case 0:
          return const ChatPage();
        case 2:
          return const SwipePage();
        default:
          return const CameraPage();
      }
    }

    if (Provider.of<AccountViewModel>(context, listen: true).isInitialized) {
      if (Provider.of<AccountViewModel>(context, listen: true)
          .isAuthenticated()) {
        return Scaffold(
          appBar: buildAppBar(),
          body: buildBody(),
          bottomNavigationBar: buildNavigationBar(),
        );
      } else {
        return const AuthenticationPage();
      }
    } else {
      return Scaffold(body: buildProgressIndicator());
    }
  }
}