import 'package:face2face/models/photos.dart';
import 'package:face2face/models/user.dart';
import 'package:face2face/view_models/swipe_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../palette/palette.dart';

class SwipePage extends StatefulWidget {
  static const String routeName = "/swipe";

  const SwipePage({Key? key}) : super(key: key);

  @override
  State<SwipePage> createState() => _SwipePage();
}

class _SwipePage extends State<SwipePage> {
  late bool isInit = false;
  late SwipeViewModel viewModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    viewModel = Provider.of<SwipeViewModel>(context, listen: false);

    if (!isInit) viewModel.init();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is specific to the camera

    Widget buildCards() {
      List<UserAccount> cardValues =
          Provider.of<SwipeViewModel>(context, listen: true).potentialMatches;
      UserAccount currentUser =
          Provider.of<SwipeViewModel>(context, listen: true).currentUser;
      Photo currentPhoto =
          Provider.of<SwipeViewModel>(context, listen: true).currentPhoto;
      bool endOfStack =
          Provider.of<SwipeViewModel>(context, listen: true).endOfStack;

      if (cardValues.isNotEmpty && !endOfStack) {
        return buildCardForUser(context, currentUser, true, currentPhoto);
      } else {
        // END OF CARD STACK
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: const <Widget>[
            Icon(
              Icons.sentiment_dissatisfied_rounded,
              size: 80,
              color: Palette.mauve,
            ),

            Text(
                'You have already swiped through all potential matches! Chat a match or come back later.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Palette.grape)),

          ],
        );      }
    }

    return buildCards();
  }
}

Widget buildCardForUser(BuildContext context, UserAccount userAccount,
    bool withButtons, Photo photo) {
  return Scaffold(
      extendBody: true,
      body: Stack(children: [
        Stack(children: [
          Center(
              heightFactor: 1.075,
              child:
                  // SizedBox(
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Palette.pink, width: 5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40.0)),
                      ),
                      height: MediaQuery.of(context).size.height * 0.625,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network('${photo.url}.jpeg',
                              fit: BoxFit.cover)))),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.560,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Row(children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<SwipeViewModel>(context, listen: false)
                          .lastPhoto();
                    },
                  )),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<SwipeViewModel>(context, listen: false)
                          .nextPhoto();
                    },
                  ))
            ]),
          )
        ]),
        Column(children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.560,
              width: MediaQuery.of(context).size.width),
          Container(
            decoration: const BoxDecoration(
              color: Palette.pink,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            width: MediaQuery.of(context).size.width * 0.95,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
                child: Text(
                  '${userAccount.displayName}, ${userAccount.age}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                child: Text('${userAccount.shortBio}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.white)),
              ),
            ]),
          ),
          if (withButtons)
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
                width: MediaQuery.of(context).size.width),
          if (withButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<SwipeViewModel>().dislikeUser();
                  },
                  icon: const Icon(
                    Icons.heart_broken_sharp,
                    color: Palette.grape,
                    size: 60.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<SwipeViewModel>().likeUser();
                  },
                  icon: const Icon(
                    Icons.favorite_sharp,
                    color: Palette.pink,
                    size: 60.0,
                  ),
                ),
              ],
            ),
        ])
      ]));
}
