import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../models/user_model.dart';
import '../models/users_model.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SwipePage createState() => _SwipePage();
}

class _SwipePage extends State<SwipePage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    for (User user in users) {
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
                return Container(
                  child:
                    Image(
                      image: AssetImage(_swipeItems[index].content.images[0]),
                      fit: BoxFit.fitHeight,
                    ),
                    //Text(_swipeItems[index].content.displayName),
                );
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
