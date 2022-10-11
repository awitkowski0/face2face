import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'page.dart';

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

  // This would actually be populated from the database
  final List<Content> pages = [
    Content(
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
    ),
    Content(
      images: const <String>[
        'assets/images/profiles/chris0.jpeg',
        'assets/images/profiles/chris1.jpeg',
        'assets/images/profiles/chris2.jpeg',
        'assets/images/profiles/chris3.jpeg',
      ],
      displayName: 'Chris',
      shortBio: 'I like to code',
      major: 'Computer Science',
      occupation: 'Software Engineer',
      pronouns: 'He/Him',
      age: 21,
    ),
    Content(
      images: const <String>[
        'assets/images/profiles/chase0.jpeg',
        'assets/images/profiles/chase1.jpeg',
        'assets/images/profiles/chase2.jpeg',
        'assets/images/profiles/chase3.jpeg',
      ],
      displayName: 'Chase',
      shortBio: 'I like to hike',
      major: 'Mechanical Engineering',
      occupation: 'Mechanic',
      pronouns: 'He/Him',
      age: 19,
    )
  ];

  @override
  void initState() {
    for (Content content in pages) {
      _swipeItems.add(SwipeItem(
          content: content,
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
