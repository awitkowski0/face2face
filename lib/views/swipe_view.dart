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
  final List<String> _names = <String>["Jacob", "Chris"];
  final List<String> _photos = <String>['assets/images/profiles/chase0.jpeg', 'assets/images/profiles/james0.jpeg'];
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
                return Container(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: AssetImage(_photos[index]),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 80,
                          width: 340,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _names[index],
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21,
                                  ),
                                ),
                                Text(
                                  "Age",
                                  // UserAccount.age,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    // Image(
                    //  image: AssetImage(_swipeItems[index].content.images[0]),
                    //  fit: BoxFit.fitHeight,
                    // ),
                    //Text(_swipeItems[index].content.displayName),
                  ])
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
