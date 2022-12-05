import 'package:face2face/palette.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../view_models/users_viewmodel.dart';
import 'dart:convert';

// TODO: figure out why it only ever shows 2 cards and then breaks...
// TODO: decide if we want like and dislike or just swiping
// TODO: Add bio below name -- do we want to stick with using random generator or use firebase?



class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  _SwipePage createState() => _SwipePage();
}
// return Image.network(_swipeItems[index].content.photos[0].url + 'jpeg');
class _SwipePage extends State<SwipePage> {
  late List usersData;
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  bool isLoading = true;
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // TODO: use real data from firebase
  final String url = "https://randomuser.me/api/?results=10";

  Future decodeData() async {
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );

    List data = jsonDecode(response.body)['results'];
    setState(() {
      usersData = data;
    // have to replace below to use user data!!
      if (usersData.isNotEmpty) {
        for (int i = 0; i < usersData.length; i++) {
          _swipeItems.add(SwipeItem(
            content: usersData[i]['name']['first'],
                likeAction: () {
                  print("liked");
                },
                nopeAction: () {
                  print("disliked");
                },
                onSlideUpdate: (SlideRegion? region) async {
                  print("Region $region");
                }));
        } //for loop
        _matchEngine = MatchEngine(swipeItems: _swipeItems);
        isLoading = false;
      } //if
    }); // setState
    // for (UserAccount user in users) {
    //   _swipeItems.add(SwipeItem(
    //       content: user,
    //       likeAction: () {
    //         print("liked");
    //       },
    //       nopeAction: () {
    //         print("disliked");
    //       },
    //       onSlideUpdate: (SlideRegion? region) async {
    //         print("Region $region");
    //       }));
    // } //for
    // _matchEngine = MatchEngine(swipeItems: _swipeItems);
    // isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    decodeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.indigo[50],
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        // TODO: reset or use as padding
        toolbarHeight: 10.0,
        titleSpacing: 36.0,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: SwipeCards(
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Card(
                          margin: const EdgeInsets.all(16.0),
                          elevation: 12.0,
                          color: Colors.white,
                          // TODO: Figure out how to add padding to banner so that both have white border?
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              child: Image.network(
                                // "https://images.pexels.com/photos/3532552/pexels-photo-3532552.jpeg?cs=srgb&dl=pexels-hitesh-choudhary-3532552.jpg&fm=jpg",
                                usersData[index]['picture']['large'],

                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20.0),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 72.0,
                            decoration: const BoxDecoration(
                              // TODO: make transparent? maybe
                                color: Palette.orchid),
                            margin: const EdgeInsets.fromLTRB(
                                18.0, 10.0, 14.0, 10.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(10.0),
                                        child: Text(
                                          usersData[index]['name']
                                          ['first'] +
                                              ", " +
                                              usersData[index]['dob']
                                              ['age']
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  onStackFinished: () {
                    // TODO: add onStackFinished
                  },
                  itemChanged: (SwipeItem item, int index) {
                    print("item: ${item.content.text}, index: $index");
                  },
                  upSwipeAllowed: true,
                  fillSpace: true,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(
                      Icons.heart_broken_outlined,
                        color: Palette.grape,
                        size: 60.0,
                    ),
                    onPressed: () {
                      // TODO: change to dislike
                      _matchEngine!.currentItem?.nope();
                    },
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_sharp,
                      color: Palette.pink,
                      size: 60.0,
                    ),
                    onPressed: () {
                      _matchEngine!.currentItem?.like();
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}