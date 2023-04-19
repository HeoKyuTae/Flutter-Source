import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Game3 extends StatefulWidget {
  const Game3({super.key});

  @override
  State<Game3> createState() => _Game3State();
}

class _Game3State extends State<Game3> {
  ScrollController scrollController = ScrollController();
  Random random = Random();

  List list = [];
  int count = 1;
  int idx = 0;

  @override
  void initState() {
    scrollController.addListener(_addListener);
    for (var i = 0; i < 100; i++) {
      item();
    }
    super.initState();
  }

  _addListener() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  item() {
    list.add('$count');
    // list.add(Container(
    //   width: 100,
    //   height: 100,
    //   alignment: Alignment.center,
    //   color: Color.fromRGBO(
    //     random.nextInt(255),
    //     random.nextInt(255),
    //     random.nextInt(255),
    //     1,
    //   ),
    //   child: Text('$count'),
    // ));

    setState(() {
      count++;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  Container(
                    width: size.width / 3,
                  ),
                  Expanded(
                    child: Transform(
                      transform: Matrix4(
                        1, 0, 0, 0, //
                        -0.1, 1, 0, -0.0014,
                        0, 0, 1, 0,
                        0, 0, 0, 1,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 220, 220),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10.0,
                              offset: const Offset(0, 10), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                child: Transform(
                                  transform: Matrix4(
                                    1, 0, 0, 0, //
                                    0.3, 1, 0, 0.0052,
                                    0, 0, 1, 0,
                                    0, 0, 0, 1,
                                  ),
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    height: 100,
                                    color: Colors.green,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.asset(
                                          'assets/images/ttt.png',
                                          fit: BoxFit.cover,
                                        ),
                                        Text('$index'),
                                      ],
                                    ),
                                  ),
                                ),
                                heightFactor: 0.3,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 3,
                  ),
                ],
              )),
              ClipRRect(
                child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (list.isEmpty) {
                                return;
                              }

                              list.removeLast();
                            });
                          },
                          child: const Text('L')),
                      const SizedBox(
                        width: 32,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (list.isEmpty) {
                                return;
                              }

                              list.removeLast();
                            });
                          },
                          child: const Text('R'))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
