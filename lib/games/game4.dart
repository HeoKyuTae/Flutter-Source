import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Game4 extends StatefulWidget {
  const Game4({super.key});

  @override
  State<Game4> createState() => _Game4State();
}

class _Game4State extends State<Game4> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
    reverseCurve: Curves.easeOut,
  );

  Color circleColor = Colors.yellow;

  bool isGetItem = true;
  double gage = 44;
  double water = 100;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  add() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 500,
            color: Colors.blue,
          );
        }).then((value) {
      if (value != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            color: Colors.white,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/game/example.jpeg',
                  fit: BoxFit.fill,
                ),
                // Image.asset(
                //   'assets/game/bg.png',
                //   fit: BoxFit.fill,
                // ),
                // Positioned(
                //   left: 0,
                //   right: 0,
                //   bottom: -50,
                //   child: Image.asset(
                //     'assets/game/front.png',
                //     fit: BoxFit.contain,
                //     width: Get.width,
                //     // height: 300,
                //   ),
                // ),
                Positioned(
                    bottom: 200,
                    left: 32,
                    child: InkWell(
                      onTap: () {
                        print('수집');
                        add();
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.red.withOpacity(0.3),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              top: 10,
                              left: 18,
                              child: Container(
                                alignment: Alignment.center,
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  border: Border.all(color: Colors.white, width: 5),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: const Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/game/drop.png',
                                  width: 25,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 0,
                              child: Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(35),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '수집',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 90,
                    right: 32,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (gage >= 150) {
                            gage = 0;
                            water += 100;
                            isGetItem = true;
                          } else {
                            if (water <= 0) {
                              water = 0;
                            } else {
                              gage += 10;
                              water -= 50;
                            }
                          }
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.blue.withOpacity(0.3),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 25,
                                    child: Stack(
                                      children: [
                                        Text(
                                          '${water.toInt()}ml',
                                          style: TextStyle(
                                            fontSize: 15,
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 3
                                              ..color = Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        Text(
                                          '${water.toInt()}ml',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 200,
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    height: 15,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: gage,
                        decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(44)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: isGetItem,
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '축하합니다',
                    style: TextStyle(
                      color: Colors.yellow[100],
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    '물 ${water.toInt()}ml를 받았어요!',
                    style: TextStyle(
                      color: Colors.yellow[100],
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: Get.width - 50,
                    height: Get.width - 50,
                    child: Stack(
                      children: [
                        FadeTransition(
                          opacity: _animation,
                          child: Container(
                            width: Get.width - 50,
                            height: Get.width - 50,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [
                                circleColor,
                                Colors.transparent,
                              ]),
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: Get.width - 50,
                            height: Get.width - 50,
                            child: Image.asset(
                              'assets/game/input.png',
                              width: 150,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    // color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isGetItem = !isGetItem;
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                border: Border.all(color: Colors.black.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
