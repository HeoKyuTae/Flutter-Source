import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ListViewDetect extends StatefulWidget {
  const ListViewDetect({super.key});

  @override
  State<ListViewDetect> createState() => _ListViewDetectState();
}

class _ListViewDetectState extends State<ListViewDetect> {
  late AutoScrollController _autoGridScrollController;
  var random = Random();
  int i = 0;

  @override
  void initState() {
    _autoGridScrollController = AutoScrollController()..addListener(_addListener);
    super.initState();
  }

  @override
  void dispose() {
    _autoGridScrollController.dispose();
    super.dispose();
  }

  _addListener() {
    print(_autoGridScrollController.position);
  }

  indexToScroll(int i) {
    _autoGridScrollController.scrollToIndex(
      i,
      duration: const Duration(milliseconds: 1000),
      preferPosition: AutoScrollPosition.begin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            controller: _autoGridScrollController,
            itemCount: 10,
            itemBuilder: (context, index) {
              return AutoScrollTag(
                key: ValueKey(index),
                controller: _autoGridScrollController,
                index: index,
                builder: (context, highlight) {
                  if (index != 0) {
                    print('${index - 1} : ${highlight.status}');
                  }
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: GestureDetector(
                      onTap: () {
                        // indexToScroll(index);
                      },
                      child: AspectRatio(
                        aspectRatio: 0.8,
                        child: Container(
                          // height: random.nextInt(600) + 100.toDouble(),
                          color: Colors.black,
                          child: Text(
                            '$index',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                // child: Padding(
                //   padding: const EdgeInsets.all(1.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       indexToScroll(index);
                //     },
                //     child: Container(
                //       height: random.nextInt(600).toDouble(),
                //       color: Colors.black,
                //       child: Text(
                //         '$index',
                //         style: const TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 21,
                //             fontStyle: FontStyle.italic),
                //       ),
                //     ),
                //   ),
                // ),
              );
            },
          ),
        ),
      ),
    );
  }
}
