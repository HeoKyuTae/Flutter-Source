import 'package:flutter/material.dart';
import 'package:make_source/games/content.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class Game2 extends StatefulWidget {
  const Game2({super.key});

  @override
  State<Game2> createState() => _Game2State();
}

class _Game2State extends State<Game2> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
  ];
  List<Color> _colors = [
    Colors.red,
    Colors.blue.withOpacity(0.1),
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            child: Column(children: [
      Container(
        height: 550,
        child: Row(
          children: [
            SizedBox(
              width: size.width / 4,
            ),
            Expanded(
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    alignment: Alignment.center,
                    color: _swipeItems[index].content.color,
                    child: Text(
                      _swipeItems[index].content.text,
                      style: const TextStyle(fontSize: 100),
                    ),
                  );
                },
                onStackFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Stack Finished"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                itemChanged: (SwipeItem item, int index) {
                  print("item: ${item.content.text}, index: $index");
                },
                upSwipeAllowed: true,
                fillSpace: true,
              ),
            ),
            SizedBox(
              width: size.width / 4,
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {
                _matchEngine.currentItem?.nope();
              },
              child: Text("Nope")),
          ElevatedButton(
              onPressed: () {
                _matchEngine.currentItem?.superLike();
              },
              child: Text("Superlike")),
          ElevatedButton(
              onPressed: () {
                _matchEngine.currentItem?.like();
              },
              child: Text("Like"))
        ],
      )
    ])));
  }
}
