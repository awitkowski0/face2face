import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../models/user.dart';
import '../view_models/users_viewmodel.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SwipePage createState() => _SwipePage();
}

class _SwipePage extends State<SwipePage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  final List<String> _photos = ["assets/images/profiles/chase0.jpeg", "assets/images/profiles/chris0.jpeg", "assets/images/profiles/james0.jpeg"];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    for (UserAccount user in users) {
      _swipeItems.add(SwipeItem(
          content: user,
          likeAction: () {
            print('Test');
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: SwipeCards(
              matchEngine: _matchEngine!,
              itemBuilder: (BuildContext context, int index) {
                //return Image(image: MemoryImage(getUserPhoto(_swipeItems[index].content)));
                print(_swipeItems[index].content.photos[0].url);
                return Image.network(_swipeItems[index].content.photos[0].url + 'jpeg');
              },
              onStackFinished: () {},
              itemChanged: (SwipeItem item, int index) {
                print("item: ${item.content.displayName}, index: $index");
              },
              upSwipeAllowed: true,
              fillSpace: true,
            ),
          )
        ]));
  }
}
