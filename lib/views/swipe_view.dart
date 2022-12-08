import 'package:face2face/models/photos.dart';
import 'package:face2face/models/user.dart';
import 'package:face2face/view_models/swipe_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../palette/palette.dart';

class SwipePage extends StatefulWidget {
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
      List<UserAccount> cardValues = Provider.of<SwipeViewModel>(context, listen: true).potentialMatches;
      UserAccount currentUser = Provider.of<SwipeViewModel>(context, listen: true).currentUser;
      Photo currentPhoto = Provider.of<SwipeViewModel>(context, listen: true).currentPhoto;

      if (cardValues.isNotEmpty) {
        return Scaffold(
            key: _scaffoldKey,
            extendBody: true,
            body: Stack(children: [
              Stack(
                  children: [
                    Center(
                        heightFactor: 1.425,
                        child:
                        // SizedBox(
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Palette.orchid, width:5),
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            ),
                            height: MediaQuery.of(context).size.height * 0.65,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child:
                            ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network('${currentPhoto.url}.jpeg', fit: BoxFit.cover)
                            )
                        )
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child:
                      Row(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height * 0.65,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<SwipeViewModel>().lastPhoto();
                                  },
                                )
                            ),
                            Container(
                                height: MediaQuery.of(context).size.height * 0.65,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<SwipeViewModel>().nextPhoto();
                                  },
                                )
                            )
                          ]
                      ),
                    )]
              ),
              Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.7, width: MediaQuery.of(context).size.width),
                    Container(
                      decoration: BoxDecoration(
                        color: Palette.orchid,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                              child: Text(
                                '${currentUser.displayName}, ${currentUser.age}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
                              child: Text(
                                  '${currentUser.shortBio}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025, width: MediaQuery.of(context).size.width),
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
            ])
        );
      } else {
        // TODO: Empty "end of card" sad card
        return const Center(child: CircularProgressIndicator());
      }
    }

    return buildCards();
  }
}